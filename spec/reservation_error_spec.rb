require_relative 'spec_helper'

RSpec.describe 'Reservation error feature' do
  let(:reservation_error_page) { ReservationConfirm::ReservationError.new }
  let(:reservation_form_page) { ReservationForm.new }

  describe 'visiting reservation error page' do
    subject { reservation_error_page.load }
    example do
      subject
      expect(reservation_error_page).to be_displayed & be_all_there
      expect(reservation_error_page.page_title).to include(
        title:   '予約エラー',
        heading: '予約エラー'
      )
      expect(reservation_error_page.error_message.text).to eq '年月日、期間、人数いずれかの値が半角英数の範囲外です'
    end

    context 'when returning to reservation form' do
      before { reservation_form_page.load }
      context 'with back button' do
        example do
          subject
          reservation_error_page.back_button.click
          expect(reservation_form_page).to be_displayed
        end
      end

      context 'with home button' do
        example do
          subject
          reservation_error_page.home_button.click
          expect(reservation_form_page).to be_displayed
        end
      end

      context 'with brand button' do
        example do
          subject
          reservation_error_page.brand_button.click
          expect(reservation_form_page).to be_displayed
        end
      end
    end
  end
end
