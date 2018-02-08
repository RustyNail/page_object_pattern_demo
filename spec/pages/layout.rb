class Layout < SitePrism::Page
  element :brand_button, ".brand[href='index.html']"
  section :nav, '.nav' do
    element :home_button, "[href='index.html']"
  end
  element :page_title, '.container > h1'
end
