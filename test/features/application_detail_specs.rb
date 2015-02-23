require "./test/test_helper"

class ApplicationDetailTest < Minitest::Test



  include Capybara::DSL

  def test_user_sees_application_details_page
    visit '/sources/jumpstartlab'
    within ('h1') do
      assert page.has_content?("jumpstartlab")
    end
  end

  def test_user_sees_most_requested_urls_link
    visit '/sources/jumpstartlab'
    assert page.has_content?("Most requested URLS")
  end

  def test_user_sees_application_details_that_are_links
    visit '/sources/jumpstartlab'
    within('ul') do
      assert find_link('Most requested URLS')[:href]
      assert find_link("Web browser breakdown")
      assert find_link("OS breakdown across all requests")
      assert find_link("Screen Resolution across all requests")
      assert find_link("Longest, average response time per URL to shortest, average response time per URL")
      assert find_link("Hyperlinks of each url to view url specific data")
      assert find_link("Hyperlink to view aggregate event data")
    end
  end

end
