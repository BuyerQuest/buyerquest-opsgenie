require 'rest-client'
require 'json'
require 'uri'
require 'buyerquest/opsgenie/version'
require 'buyerquest/opsgenie/client'
require 'buyerquest/opsgenie/heartbeat'
require 'buyerquest/opsgenie/alert'


module Buyerquest
  module Opsgenie
    class Error < StandardError; end
  end
end
