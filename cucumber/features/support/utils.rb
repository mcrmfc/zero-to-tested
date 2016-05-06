module TestWorld
  # utils module
  module Utils
    def page_contains_error?(url, attempt = 1)
      errors = ['thou shalt not pass',
                'hmmm bad times',
                "oh dear we don't seem to have that for you"]
      error = errors.find { |e| Capybara.current_session.has_content?(e, wait: false) }
      log.error "ERROR - #{error} - WILL RELOAD #{url} - attempt #{attempt + 1}" if error
      error
    end
  end
end
