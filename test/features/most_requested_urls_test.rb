require "./test/test_helper"

class MainPageTest < Minitest::Test
  include Capybara::DSL

  def test_user_sees_greeting
    source = Source.create(rootUrl: "http://jumpstartlab.com/blog", identifier: "jumpstartlab")
    source.payloads.create(:url.find_or_create_by(address: 'http://jumpstartlab.com/blog/example')
    source.payloads.create(:url.find_or_create_by(address: 'http://jumpstartlab.com/blog/example')
    source.payloads.create(:url.find_or_create_by(address: 'http://jumpstartlab.com/blog/example')
    visit '/sources/jumpstartlab/most_requested'
    assert page.has_content?("Hello")
  end

end
