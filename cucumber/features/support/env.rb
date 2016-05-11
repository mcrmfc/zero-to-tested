require 'capybara/cucumber'
require 'rspec/expectations'
require 'capybara/poltergeist'
require 'site_prism'
require 'capybara-screenshot/cucumber'
require 'logging'
require_relative 'wait'
require_relative 'logger'
require_relative 'pages'
require_relative '../../zeroapp/app'

World(TestWorld::Pages)
World(TestWorld::Logger)
World(TestWorld::Wait)

# start test app
`pumactl -F zeroapp/puma.rb start`

Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 30
Capybara.app = ZeroApp
Capybara.app_host = 'http://localhost:4567'

# FIXME: https://github.com/mattheworiordan/capybara-screenshot/issues/170
Capybara.save_and_open_page_path = '../reports'

# stop test app
at_exit { `pumactl -F zeroapp/puma.rb stop` }
