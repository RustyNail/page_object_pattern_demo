class Layout < SitePrism::Page
  element :brand_button, ".brand[href='index.html']"
  section :nav, '.nav' do
    element :home_button, "[href='index.html']"
  end
  element :page_heading, '.container > h1'

  def page_title
    {
      heading: page_heading.text,
      title: title
    }
  end
end
