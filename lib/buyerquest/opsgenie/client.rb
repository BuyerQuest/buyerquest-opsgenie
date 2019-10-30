module Buyerquest
  module Opsgenie
    module Client
      OPSGENIE_API_BASE_URL = 'https://api.opsgenie.com/v2'.freeze

      def self.init(api_key = nil, opts={})
        @api_key = api_key
        @api_key ||= ENV['OPSG_API_KEY']
        raise "[OpsGenie Error] No api key provided" if @api_key.nil?
      end

      def self.execute(opsgenie_request)
        uri = URI::encode(opsgenie_request[:uri])
        method = opsgenie_request[:method].upcase
        payload = opsgenie_request[:payload]
        raise "[OpsGenie Error] Unknown method" unless %w(GET POST PUT PATCH DELETE).include? method
        request = {
            :method => method,
            :url => "#{OPSGENIE_API_BASE_URL}#{uri}",
            :headers => get_headers(method)
        }
        request[:payload] = payload.to_json unless payload.nil?
        begin
          response = RestClient::Request.execute(request)
        rescue RestClient::NotFound => err
          return nil
        end
        JSON.parse(response)
      end

      def self.get_headers(http_method)
        headers = {:Authorization => "GenieKey #{@api_key}"}
        if %w(POST PATCH).include? http_method.upcase
          headers[:content_type] = 'application/json'
        end
        headers
      end
    end
  end
end
