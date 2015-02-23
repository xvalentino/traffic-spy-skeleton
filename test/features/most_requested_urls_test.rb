require "./test/test_helper"

class MainPageTest < BaseTest 
  include Capybara::DSL

  def test_user_sees_one_of_their_urls
    skip
    create_source
    create_payload
    visit '/sources/jumpstartlab/most_requested'
    assert_equal 1, page.all("li").size
  end

  def test_user_see_multiple_urls
    skip
    create_source
    create_payload
    create_payload
    visit '/sources/jumpstartlab/most_requested'
    assert_equal 2, page.all("li").size
  end

  def test_arranges_urls
    create_source
    create_payload
    create_other_payload
    create_payload
    visit '/sources/jumpstartlab/most_requested'
    save_and_open_page
    assert_equal 2, page.all("li").size
  end

  def create_source
    Source.create(identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com/")
  end

  def create_payload
    source = Source.find_by(identifier: "jumpstartlab")
    source.payloads.create(url: Url.find_or_create_by(address: 'http://jumpstartlab.com/blog/first_example'))
  end

  def create_other_payload
    source = Source.find_by(identifier: "jumpstartlab")
    source.payloads.create(url: Url.find_or_create_by(address: 'http://jumpstartlab.com/blog/other_example'))
  end
end

