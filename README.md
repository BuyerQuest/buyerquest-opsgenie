# Buyerquest Opsgenie Ruby gem

This gem provides opsgenie related functionality

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'buyerquest-opsgenie'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install buyerquest-opsgenie

## Usage

### Alert creation
Example:
```ruby
require 'buyerquest/opsgenie'

# Initialise client singleton
Buyerquest::Opsgenie::Client.init('****') 
# alternatively export OPSG_API_KEY to the runtime environment and then this one
# Buyerquest::Opsgenie::Client.init 

# Prepare alert object instance 
alert_payload = {message: "I'm alert from buyerquest-opsgenie gem",alias: 'no-duplication', description: 'buyerquest-opsgenie gem alert'}
test_alert = Buyerquest::Opsgenie::Alert.new(alert_payload)

# Fire alert
test_alert.create
```

### Heartbeat usage
```ruby
require 'buyerquest/opsgenie'

# Initialise client singleton
Buyerquest::Opsgenie::Client.init('****') 
# alternatively export OPSG_API_KEY to the runtime environment and then this one
# Buyerquest::Opsgenie::Client.init 

# Prepare alert object instance 
heartbeat_payload = {name: 'Test heartbeat'}
test_heartbeat = Buyerquest::Opsgenie::Heartbeat.new(heartbeat_payload)

# Start heartbeat
test_heartbeat.start
```

