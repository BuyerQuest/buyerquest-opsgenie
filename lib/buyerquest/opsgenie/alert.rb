module Buyerquest
  module Opsgenie
    class Alert
      # @param [Hash]
      # @option opts [String] message
      # @option opts [String] alias
      # @option opts [String] description
      # @option opts [Array] tags
      # @option opts [Hash] details
      def initialize(opts={})
        @message = opts[:message]
        @opts = opts
      end

      def create
        opsg_request ={
            :method  => 'POST',
            :uri     => '/alerts',
            :payload => {
                :message      => @message,
                :alias        => @opts[:alias],
                :description  => @opts[:description],
                :tags         => @opts[:tags],
                :details      => @opts[:details],
            }
        }

        Buyerquest::Opsgenie::Client.execute opsg_request
      end
    end
  end
end
