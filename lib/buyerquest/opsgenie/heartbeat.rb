module Buyerquest
  module Opsgenie
    class Heartbeat
      attr_reader :name

      def initialize(opts={})
        @name = opts[:name]
        @opts = opts
        raise "[OpsGenie Error] No name provided" if @name.nil?
      end

      def start
        self.update({}) unless self.add
        self.enable
        # Initial ping request
        self.ping
      end

      def stop
        self.disable
        self.delete
      end

      def get_default_heartbeat_opts
        {
            :intervalUnit => "minutes",
            :interval => 10,
            :enabled => true,
            :alertMessage => "Heartbeat [#{@name}] expired",
            :alertPriority=> "P3"
        }
      end

      def enable
        raise "[OpsGenie Error] Can't enable non-existent heartbeat" unless exist?
        opsg_request ={
            :method  => 'POST',
            :uri     => "/heartbeats/#{@name}/enable",
        }
        Buyerquest::Opsgenie::Client.execute opsg_request
      end

      def disable
        raise "[OpsGenie Error] Can't enable non-existent heartbeat" unless exist?

        opsg_request ={
            :method  => 'POST',
            :uri     => "/heartbeats/#{@name}/disable",
        }
        Buyerquest::Opsgenie::Client.execute opsg_request
      end

      def add
        return false if exist?
        default_opts = get_default_heartbeat_opts
        payload = default_opts
        payload = payload.merge @opts
        payload[:name] = @name
        opsg_request = {
            :method  => 'POST',
            :uri     => '/heartbeats',
            :payload => payload
        }
        @exist_status =  Buyerquest::Opsgenie::Client.execute opsg_request
        true
      end

      def ping
        raise "[OpsGenie Error] Can't ping non-existent heartbeat" unless exist?
        opsg_request ={
            :method  => 'GET',
            :uri     => "/heartbeats/#{@name}/ping",
        }
        Buyerquest::Opsgenie::Client.execute opsg_request
      end

      def update (opts)
        raise "[OpsGenie Error] Can't update non-existent heartbeat" unless exist?
        @opts = @opts.merge opts
        default_opts = get_default_heartbeat_opts
        payload = default_opts
        payload = payload.merge @opts
        payload[:name] = @name

        opsg_request = {
            :method  => 'PATCH',
            :uri     => "/heartbeats/#{@name}",
            :payload => payload
        }
        @exist_status = Buyerquest::Opsgenie::Client.execute opsg_request
        true
      end

      def delete
        return false unless exist?
        opsg_request ={
            :method  => 'DELETE',
            :uri     => "/heartbeats/#{@name}",
        }
        Buyerquest::Opsgenie::Client.execute opsg_request
        @exist_status = nil
        true
      end

      def get
        opsg_request ={
            :method  => 'GET',
            :uri     => "/heartbeats/#{@name}",
        }
        Buyerquest::Opsgenie::Client.execute opsg_request
      end

      def exist?
        if @exist_status.nil?
          @exist_status = get
        end
        if @exist_status.nil?
          false
        else
          true
        end
      end
    end
  end
end
