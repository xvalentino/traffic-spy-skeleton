require './test/test_helper'

class UrlStatsPageTest < Minitest::Test

  include Capybara::DSL

  def test_user_sees_stats_greeting
    visit '/sources/:identifier/urls/:relative_path'
    within ('h1') do
      assert page.has_content?("URL Stats")
    end
  end

end
