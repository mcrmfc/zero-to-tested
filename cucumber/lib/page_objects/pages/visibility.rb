# page object for Visibility page
class Visibility < SitePrism::Page
  set_url '/visibility'

  element :content, '#test'
end
