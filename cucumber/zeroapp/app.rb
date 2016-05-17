require 'sinatra'
require 'json'

# hit counting
class HitCounter
  @hit_count = 0

  class << self
    attr_reader :hit_count

    def increment_hit_count(delay = 0)
      sleep delay
      @hit_count += 1
    end
  end
end

# Test App
class ZeroApp < Sinatra::Base
  get '/status' do
    'OK'
  end

  get '/flaky' do
    status_code = [200, 500, 503].sample
    status_code == 200 ? 'you made it' : status_code
  end

  get '/ajaxy' do
    "<html><head></head><body><div id='test'></div><script>"\
      "setTimeout(function() { document.getElementById('test').innerHTML = 'delayed'; }, 5000);"\
      '</script></body></html>'
  end

  get '/hits' do
    content_type :json
    { hits: HitCounter.hit_count }.to_json
  end

  put '/hit' do
    Thread.new { HitCounter.increment_hit_count(5) }
  end

  not_found do
    "oh dear we don't seem to have that for you"
  end

  error 500 do
    'hmmm bad times'
  end

  error 503 do
    'thou shalt not pass'
  end
end
