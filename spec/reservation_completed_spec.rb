require_relative 'spec_helper'

RSpec.describe 'Reservation completed feature' do
  let(:reservation_completed_page) { ReservationCompleted.new }
  let(:reservation_form_page) { ReservationForm.new }

  describe 'visiting reservation completed page' do
    subject { reservation_completed_page.load }
    example do
      subject
      expect(reservation_completed_page).to be_displayed & be_all_there
      expect(reservation_completed_page.page_title).to include(
        title:   '予約完了',
        heading: '予約を完了しました'
      )
      expect(reservation_completed_page.message.text).to include 'ご来館、心よりお待ちしております。'
    end

    context 'when returning to reservation form' do
      context 'with home button' do
        example do
          subject
          reservation_completed_page.nav.home_button.click
          expect(reservation_form_page).to be_displayed
        end
      end

      context 'with brand button' do
        example do
          subject
          reservation_completed_page.brand_button.click
          expect(reservation_form_page).to be_displayed
        end
      end
    end
  end
end
