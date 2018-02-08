require_relative 'layout'

class ReservationConfirm < Layout
  set_url '/reserveApp_Renewal/check_info.html{?query*}'

  element :back_button, '#returnto_index'
  section :billing, '#billing' do
    element :total, '#total'
    element :price_detail, '#total + div'
    element :term, '#term'
    element :headcount, '#headcount'
    element :breakfast, '#breakfast'
    element :plan, '#plan'
    element :guestname, '#guestname'

    def detail
      {
        total: total.text,
        price_detail: price_detail.text,
        term: term.text,
        headcount: headcount.text,
        breakfast: breakfast.text,
        plan: plan.text,
        guestname: guestname.text
      }
    end
  end
  element :commit_button, '#commit'

  class ReservationError < self
    set_url '/reserveApp_Renewal/check_info.html{?query*}'

    element :error_message, '#errorcheck_result'
  end
end
