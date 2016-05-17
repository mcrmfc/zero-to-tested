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
end

Then(/^the response contains "you made it"$/) do
  expect(flaky).to have_text 'you made it'
end

When(/^I visit the hit count incrementer$/) do
  HTTParty.put('http://localhost:4567/hit')
end

Then(/^the hit count increments$/) do
  url = 'http://localhost:4567/hits'
  hit_count = HTTParty.get(url)
  wait_for_assertion("Hit count hasn't incremented, hit count = #{hit_count}") do
    hit_count = JSON.parse(HTTParty.get(url).body)['hits']
    expect(hit_count).to eq 1
  end
end
