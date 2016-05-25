require 'rspec'
require 'capybara/dsl'
require 'site_prism'
require_relative '../lib/page_objects/pages/flaky'

describe Flaky do
  describe 'flaky page' do
    let(:flaky) { Flaky.new }

    it 'inherits from SitePrism Base page' do
      expect(flaky.class.ancestors).to include SitePrism::Page
    end

    it 'allows access to content element' do
      expect(flaky).to respond_to :load
    end
  end
end
