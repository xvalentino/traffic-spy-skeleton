require 'useragent'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      if Source.new(params).valid?
        source = Source.create(params)
        "{\"identifier\": \"#{source.identifier}\"}"
      elsif params.length != 2
        status 400
        body = "Missing Parameters"
      else
        status 403
        body = "Identifier Already Exists"
      end
    end

    post '/sources/:identifier/data' do |identifier|

      if Payload.find_by(raw_data: params["payload"])
        status 403
        body "payload already exists"

      elsif source = Source.find_by(identifier: identifier)

        payload_params = JSON.parse(params[:payload]).symbolize_keys

        if payload_params.size != 11
          status 400
          return body "incorrect amount of payload parameters"
        end

        user_agent = UserAgent.parse(payload_params[:userAgent])

        source.payloads.create({
          raw_data: params[:payload],
          url: Url.find_or_create_by(address: payload_params[:url]),
          requested_at: payload_params[:requestedAt],
          responded_in: payload_params[:respondedIn],
          referred_by: ReferredBy.find_or_create_by(name: payload_params[:referredBy]),
          request_type: RequestType.find_or_create_by(verb: payload_params[:requestType]),
          event: Event.find_or_create_by(name: payload_params[:eventName]),
          browser: Browser.find_or_create_by(name: user_agent.browser),
          os: Os.find_or_create_by(name: user_agent.platform),
          resolution: Resolution.find_or_create_by(width: payload_params[:resolutionWidth], height: payload_params[:resolutionHeight]),
          ip_address: IpAddress.find_or_create_by(address: payload_params[:ip])
        })
        body "successful"
      else
        status 403
        body "source is not registered"
      end
    end

    get '/sources/:identifier' do |identifier|
      @identifier = identifier
      erb :application_details
    end

    get '/sources/:identifier/most_requested' do |identifier|
      payloads = Payload.where(source_id: Source.where(identifier: identifier).pluck(:id))
      most_frequent_payloads_hash = payloads.inject(Hash.new(0)) {|hash, payload| hash[payload.url_id] += 1; hash}
      most_frequent_payloads = most_frequent_payloads_hash.sort_by {|key, value| value}
      @urls = most_frequent_payloads.map do |array|
        Payload.find_by(url_id: array[1]).url.address
      end
      erb :most_requested
    end

    not_found do
      erb :error
    end

    get '/sources/:identifier/urls/:relative_path' do
      erb :url_stats
    end
  end
end
