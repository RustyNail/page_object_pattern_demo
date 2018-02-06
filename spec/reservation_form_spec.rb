require_relative 'spec_helper'

RSpec.describe 'Reservation form feature' do
  let(:reservation_form_page) { ReservationForm.new }

  describe 'visiting reservation form page' do
    subject { reservation_form_page.load }
    example do
      subject
      expect(reservation_form_page).to be_displayed & be_all_there
      expect(reservation_form_page.title).to eq '予約情報入力'
      expect(reservation_form_page.page_title.text).to eq '予約フォーム'
    end

    describe 'and inputting reservation information' do
      let(:confirm_reservation_page) { ReservationConfirm.new }
      let(:reservation_error_page) { ReservationConfirm::ReservationError.new }
      let(:params) { {} } 
      subject do
        super()
        reservation_form_page.reserve(params)
      end

      context 'when returning to reservation form' do
        context 'with back button' do
          example do
            subject
            confirm_reservation_page.back_button.click
            expect(reservation_form_page).to be_displayed
          end
        end

        context 'with home button' do
          example do
            subject
            confirm_reservation_page.nav.home_button.click
            expect(reservation_form_page).to be_displayed
          end
        end

        context 'with brand button' do
          example do
            subject
            confirm_reservation_page.brand_button.click
            expect(reservation_form_page).to be_displayed
          end
        end
      end

      context 'when all the fields are valid' do
        example do
          subject
          expect(confirm_reservation_page).to be_displayed
        end
      end

      shared_examples 'failing requests' do |error_message|
        example do
          subject
          expect(reservation_error_page).to be_displayed
          expect(reservation_error_page.error_message.text).to eq(error_message)
        end
      end

      context 'when reserve date is today' do
        let(:params) { { reserve_date: Date.today.strftime('%Y/%m/%d') } }
        include_examples 'failing requests', '宿泊日には、翌日以降の日付を指定してください。'
      end

      context 'when reserve date is too early' do
        let(:params) { { reserve_date: Date.today.next_day.next_year.strftime('%Y/%m/%d') } }
        include_examples 'failing requests', '宿泊日には、3ヶ月以内のお日にちのみ指定できます。'
      end

      context 'when reserve term is too short' do
        let(:params) { { reserve_term: 0 } }
        include_examples 'failing requests', '宿泊日数が1日以下です'
      end

      context 'when guest count is too small' do
        let(:params) { { headcount: 0 } }
        include_examples 'failing requests', '人数が入力されていません。'
      end

      context 'when guest name is blank' do
        let(:params) { { guestname: '' } }
        include_examples 'failing requests', 'お名前が指定されていません'
      end
    end
  end
end
