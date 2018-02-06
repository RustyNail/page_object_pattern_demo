class ReservationCompleted < SitePrism::Page
  set_url '/reserveApp_Renewal/final_confirm.html{?query*}'

  element :brand_button, ".brand[href='index.html']"
  section :nav, '.nav' do
    element :home_button, "[href='index.html']"
  end
  element :page_title, '.container > h1'
  element :back_button, '#returnto_checkInfo'
  element :message, '#slide1'
end
