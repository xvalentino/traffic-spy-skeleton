require './test/test_helper'

class UrlStatsPageTest < Minitest::Test

  include Capybara::DSL

  def test_user_sees_stats_greeting
    visit '/sources/:identifier/urls/:relative_path'
    within ('h1') do
      assert page.has_content?("URL Stats")
    end
  end

  def test_can_display_the_longest_response_time
    # Source.create (identifier: "jumpstartlab", rootUrl: "http://example.com")
    Source.create ({"identifier" => "jumpstartlab", "rootUrl" => "http://example.com"})

    Payload.create ({"url_id" => "http://jumpstartlab.com/blog","requested_at" => "2013-02-16 21:38:28 -0700","responded_in" => 37,"referred_by" => ReferredBy.create(name: "http://jumpstartlab.com"),"request_type_id" => "GET","event_id" => "socialLogin","browser_id" => Browser.create(name: "Chrome"),"os_id" => Os.create(name: "Macintosh"),"resolution_id" => Resolution.create(width: "1920", height: "1280"),"ip_address" => IpAddress.create(address: "63.29.38.211")})
    Payload.create ({"url_id" => "http://jumpstartlab.com/blog","requested_at" => "2013-02-16 21:38:28 -0700","responded_in" => 42,"referred_by" => ReferredBy.create(name: "http://jumpstartlab.com"),"request_type_id" => "GET","event_id" => "socialLogin","browser_id" => Browser.create(name: "Chrome"),"os_id" => Os.create(name: "Macintosh"),"resolution_id" => Resolution.create(width: "1920", height: "1280"),"ip_address" => IpAddress.create(address: "63.29.38.211")})
    Payload.create ({"url_id" => "http://jumpstartlab.com/blog","requested_at" => "2013-02-16 21:38:28 -0700","responded_in" => 55,"referred_by" => ReferredBy.create(name: "http://jumpstartlab.com"),"request_type_id" => "GET","event_id" => "socialLogin","browser_id" => Browser.create(name: "Chrome"),"os_id" => Os.create(name: "Macintosh"),"resolution_id" => Resolution.create(width: "1920", height: "1280"),"ip_address" => IpAddress.create(address: "63.29.38.211")})

    visit '/sources/:identifier/urls/:relative_path'

    within ('h3') do
      assert page.has_content?(55)
    end
  end

end
