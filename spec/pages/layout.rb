class Layout < SitePrism::Page
  element :brand_button, ".brand[href='index.html']"
  element :home_button, ".nav [href='index.html']"
  element :page_heading, '.container > h1'

  def page_title
    {
      heading: page_heading.text,
      title: title
    }
  end
end
