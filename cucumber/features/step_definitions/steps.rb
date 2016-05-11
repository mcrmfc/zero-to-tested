When(/^I visit status url$/) do
  status.load
end

When(/^I visit ajaxy url$/) do
  ajaxy.load
end

When(/^I visit flaky url$/) do
  flaky.load
end

Then(/^the response contains "OK"$/) do
  expect(status).to have_text 'OK'
end

Then(/^the response contains "delayed"$/) do
  expect(ajaxy.content).to have_text 'delayed'
  # wait_for_assertion('Cannot find content') { expect(ajaxy.content.text).to eq 'delayed' }
end

Then(/^the response contains "you made it"$/) do
  expect(flaky).to have_text 'you made it'
end
