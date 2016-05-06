When(/^I visit Google$/) do
  visit 'http://www.google.com'
end

Then(/^the title is "([^"]*)"$/) do |title|
  expect(page.title).to eq title
end
