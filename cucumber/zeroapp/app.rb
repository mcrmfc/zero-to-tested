require 'sinatra'

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
