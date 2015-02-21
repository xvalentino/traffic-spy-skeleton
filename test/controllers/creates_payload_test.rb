require "./test/test_helper"
require 'json'

class CreatesPayloadTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end


  def test_creates_payload_with_attributes
    skip
    Source.create(identifier: "jumpstartlab", rootUrl: "http://example.com")

    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'


    assert_equal 1, Payload.count
    assert_equal 200, last_response.status
    assert_equal "successful", last_response.body

  #   assert_equal 1, Url.count
  #   assert_equal 1, Referrer.count
  #   assert_equal 1, RequestType.count
  #   assert_equal 1, IpAddress.count
  #   assert_equal 1, Event.count
  #   assert_equal 1, Resolution.count
  #   assert_equal 1, Browser.count
  #   assert_equal 1, OS.count
  end

  def test_cannot_create_payload_without_being_registered
    skip
    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 0, Payload.count
    assert_equal 403, last_response.status
    assert_equal "source is not registered", last_response.body
  end

  def teardown
    DatabaseCleaner.clean
  end
end