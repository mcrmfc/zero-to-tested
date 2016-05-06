# page object for Ajaxy page
class Ajaxy < SitePrism::Page
  set_url '/ajaxy'

  element :content, '#test'
end
