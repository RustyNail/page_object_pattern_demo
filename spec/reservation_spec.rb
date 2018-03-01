require_relative 'spec_helper'

RSpec.describe 'Reservation feature' do
  let(:reservation_form_page_url) { 'http://example.selenium.jp/reserveApp_Renewal/index.html' }

  describe 'visiting reservation form page' do
    shared_examples 'displayed the reservation form' do
      example do
        subject
        expect(current_path).to eq '/reserveApp_Renewal/index.html'
        expect(title).to eq '予約情報入力'
        expect(page).to have_css('#datePick') &
                        have_css('#reserve_term') &
                        have_css('#headcount') &
                        have_css('#breakfast_on') &
                        have_css('#breakfast_off') &
                        have_css('#plan_a') &
                        have_css('#plan_b') &
                        have_css('#plan_b+br+a') &
                        have_css('#guestname') &
                        have_css('#guestname+hr+a') &
                        have_css('#agree_and_goto_next') &
                        have_css('#disagree')
      end
    end

    context 'when visiting reservation form' do
      subject { visit reservation_form_page_url }

      include_examples 'displayed the reservation form'
    end

    ## Use selenium webdriver only
    context 'when click on home button' do
      before do
        caps = Selenium::WebDriver::Remote::Capabilities.chrome(
          'chromeOptions' => { args: %w[--headless disable-gpu no-sandbox window-size=1600x800] }
        )
        @driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps
        @driver.get reservation_form_page_url
      end
      subject { @driver.find_element(css: "[href='index.html']").click }

      it 'should displayed reservation form page' do
        expect(URI.parse(@driver.current_url).path).to eq '/reserveApp_Renewal/index.html'
        expect(@driver.title).to eq '予約情報入力'
        expect(@driver.find_elements(css: '#datePick').size).to be > 0
        expect(@driver.find_elements(css: '#reserve_term').size).to be > 0
        expect(@driver.find_elements(css: '#headcount').size).to be > 0
        expect(@driver.find_elements(css: '#breakfast_on').size).to be > 0
        expect(@driver.find_elements(css: '#breakfast_off').size).to be > 0
        expect(@driver.find_elements(css: '#plan_a').size).to be > 0
        expect(@driver.find_elements(css: '#plan_b').size).to be > 0
        expect(@driver.find_elements(css: '#plan_b+br+a').size).to be > 0
        expect(@driver.find_elements(css: '#guestname').size).to be > 0
        expect(@driver.find_elements(css: '#guestname+hr+a').size).to be > 0
        expect(@driver.find_elements(css: '#agree_and_goto_next').size).to be > 0
        expect(@driver.find_elements(css: '#disagree').size).to be > 0
      end
    end

    ## Also use capybara
    context 'when click on brand button' do
      before { visit reservation_form_page_url }
      subject { find(".brand[href='index.html']").click }

      include_examples 'displayed the reservation form'
    end
  end

  describe 'inputting reservation information' do
    let(:reserve_date) { Date.today.next_day }
    let(:reserve_term) { 1 }
    let(:headcount) { 1 }
    let(:breakfast) { true }
    let(:plan_a) { true }
    let(:plan_b) { true }
    let(:guestname) { '山田太郎' }
    before { visit reservation_form_page_url }
    subject do
      find('#datePick').set reserve_date.strftime('%Y/%m/%d')
      page.execute_script("$('.datepicker').hide()") # close datepicker
      find("#reserve_term option[value='#{reserve_term}']").select_option
      find("#headcount option[value='#{headcount}']").select_option
      if breakfast
        find('#breakfast_on').set true
      else
        find('#breakfast_off').set true
      end
      find('#plan_a').set plan_a
      find('#plan_b').set plan_b
      find('#guestname').set guestname

      find('#agree_and_goto_next').click
    end

    context 'when all the fields are valid' do
      it 'should displayed reservation confirmation page and details of reservation is displayed' do
        subject
        expect(current_path).to include '/reserveApp_Renewal/check_info.html'
        expect(title).to eq '予約内容確認'
        expect(page).to have_css('#billing #total') &
                        have_css('#billing #total + div') &
                        have_css('#billing #term') &
                        have_css('#billing #headcount') &
                        have_css('#billing #breakfast') &
                        have_css('#billing #plan') &
                        have_css('#billing #guestname')
        aggregate_failures do
          expect(find('#billing #total').text).to eq(
            "合計 #{reserve_date.saturday? || reserve_date.sunday? ? '11750' : '10000'}円(税込み)"
          )
          expect(find('#billing #total + div').text).to eq '(おひとり様1泊7000円～、土日は25%アップ) 料金詳細を確認'
          expect(find('#billing #term').text).to eq(
            "期間: #{reserve_date.strftime('%Y年%-m月%-d日')} 〜 #{(reserve_date + 1).strftime('%Y年%-m月%-d日')} 1泊"
          )
          expect(find('#billing #headcount').text).to eq 'ご人数: 1名様'
          expect(find('#billing #breakfast').text).to eq '朝食: あり'
          expect(find('#billing #plan').text).to eq 'プラン: 昼からチェックインプラン お得な観光プラン'
          expect(find('#billing #guestname').text).to eq "お名前: #{guestname} 様"
        end
      end
    end

    shared_examples 'failed to reserve' do |error_message|
      example do
        subject
        expect(current_path).to include '/reserveApp_Renewal/check_info.html'
        expect(title).to eq '予約エラー'
        expect(find('#errorcheck_result').text).to eq error_message
      end
    end

    context 'when reserve date is today' do
      let(:reserve_date) { Date.today }
      include_examples 'failed to reserve', '宿泊日には、翌日以降の日付を指定してください。'
    end

    context 'when reserve date is too early' do
      let(:reserve_date) { Date.today.next_year }
      include_examples 'failed to reserve', '宿泊日には、3ヶ月以内のお日にちのみ指定できます。'
    end

    context 'when reserve term is too short' do
      let(:reserve_term) { 0 }
      include_examples 'failed to reserve', '宿泊日数が1日以下です'
    end

    context 'when guest count is too small' do
      let(:headcount) { 0 }
      include_examples 'failed to reserve', '人数が入力されていません。'
    end

    context 'when guest name is blank' do
      let(:guestname) { '' }
      include_examples 'failed to reserve', 'お名前が指定されていません'
    end
  end
end
