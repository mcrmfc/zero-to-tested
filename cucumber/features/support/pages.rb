require_relative '../../lib/page_objects/pages/status'
require_relative '../../lib/page_objects/pages/ajaxy'
require_relative '../../lib/page_objects/pages/flaky'

module TestWorld
  # easy page object access
  module Pages
    def status
      @status ||= Status.new
    end

    def ajaxy
      @ajaxy ||= Ajaxy.new
    end

    def flaky
      @flaky ||= Flaky.new
    end
  end
end
