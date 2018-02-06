require_relative 'spec_helper'

RSpec.describe 'Reservation comfirm feature' do
  let(:reservation_form_page) { ReservationForm.new }
  let(:confirm_reservation_page) { ReservationConfirm.new }

  describe 'visiting reservation comfirm page' do
    before { reservation_form_page.load }
    subject { reservation_form_page.reserve }
    example do
      subject
      expect(confirm_reservation_page).to be_displayed & be_all_there
      expect(confirm_reservation_page.title).to eq '予約内容確認'
      expect(confirm_reservation_page.page_title.text).to eq '予約内容'
    end

    describe 'and inputting reservation information' do
      it 'should be displayed reservation detail' do
        subject
        expected_reserve_date =  Date.today.next_day
        expected_total = (expected_reserve_date.sunday? || expected_reserve_date.sunday?) ? 11750 : 10000
        expect(confirm_reservation_page.billing.detail).to eq(
          total: "合計 #{expected_total}円(税込み)",
          price_detail: '(おひとり様1泊7000円～、土日は25%アップ) 料金詳細を確認',
          term: "期間: #{expected_reserve_date.strftime('%Y年%-m月%-d日')} 〜 #{(expected_reserve_date + 1).strftime('%Y年%-m月%-d日')} 1泊",
          headcount: "ご人数: 1名様",
          breakfast: '朝食: あり',
          plan: 'プラン: 昼からチェックインプラン お得な観光プラン',
          guestname: "お名前: 山田太郎 様"
        )
      end

      context 'when returning to reservation form with back button' do
        subject do
          super()
          confirm_reservation_page.back_button.click
        end
        it 'should be remine inputting contnts in reservation form' do
          subject
          # Firefox retains inputted day, but chrome returns to today.
          expected_reserve_date =  Date.today
          expect(reservation_form_page.reserve_form.inputted_contents).to eq(
            reserve_date: expected_reserve_date.strftime('%Y/%-m/%-d'),
            reserve_term: '1',
            headcount: '1',
            breakfast: true, 
            plan_a: true,
            plan_b: true,
            guestname: '山田太郎'
          )
        end
      end
    end
  end
end