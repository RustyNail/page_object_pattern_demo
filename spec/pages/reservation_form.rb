require_relative 'layout'

class ReservationForm < Layout
  set_url '/reserveApp_Renewal/index.html'

  section :reserve_form, '#reserve_info' do
    element :reserve_date, '#datePick'
    element :reserve_term, '#reserve_term'
    element :headcount, '#headcount'
    element :breakfast_on, "#breakfast_on"
    element :breakfast_off, "#breakfast_off"
    element :plan_a, '#plan_a'
    element :plan_b, '#plan_b'
    element :plan_detail_link, '#plan_b+br+a'
    element :guestname, '#guestname'
    element :terms_of_service_link, '#guestname+hr+a'
    element :agree_and_goto_next, '#agree_and_goto_next'
    element :disagree, '#disagree'

    def input_elements
      %i[reserve_date reserve_term headcount breakfast plan_a plan_b guestname]
    end

    def inputted_contents
      {
        reserve_date: reserve_date.value,
        reserve_term: reserve_term.value,
        headcount: headcount.value,
        breakfast: breakfast_on.selected?,
        plan_a: plan_a.checked?,
        plan_b: plan_b.checked?,
        guestname: guestname.value
      }
    end
  end

  def reserve(params = {})
    reserve_params = {
      reserve_date: Date.today.next_day.strftime('%Y/%m/%d'),
      reserve_term: 1,
      headcount: 1,
      breakfast: true,
      plan_a: true,
      plan_b: true,
      guestname: '山田太郎'
    }
    reserve_params.merge!(params)
    reserve_form.input_elements.each do |key|
      unless reserve_params[key].nil?
        case key
        when :reserve_term, :headcount
          reserve_form.send(key).find("option[value='#{reserve_params[key]}']").select_option
        when :reserve_date
          reserve_form.send(key).set(reserve_params[key])
          page.execute_script("$('.datepicker').hide()")
        when :breakfast
          reserve_form.send(reserve_params[key] ? :breakfast_on : :breakfast_off).set(true)
        else
          reserve_form.send(key).set(reserve_params[key])
        end
      end
    end
    reserve_form.agree_and_goto_next.click
  end
end