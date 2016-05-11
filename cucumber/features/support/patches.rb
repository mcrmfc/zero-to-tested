require_relative 'utils'
require_relative 'logger'

module Capybara
  # monkey patch visit method
  # not ideal but we have to tolerate various unexpected errors in shared environments
  class Session
    include TestWorld::Utils
    include TestWorld::Logger

    # rubocop:disable Metrics/MethodLength
    alias old_visit visit
    def visit(url)
      10.times do |attempt|
        begin
          old_visit url
        rescue => errors
          log.error "Error #{errors} caught in page load: #{url}"
        end
        log.info "Loading url: #{url}"
        return true unless page_contains_error?(url, attempt)
        log.info "Waiting 2 seconds before attempting reload of: #{url}"
        sleep 2 # give a little time before requesting page again
      end
    end
  end
end
