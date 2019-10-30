# Buyerquest Opsgenie Ruby gem

This gem provides opsgenie related functionality

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'buyerquest-opsgenie'
```

And then execute:

```shell
$ bundle install
```

Or install it directly:

```shell
$ gem install buyerquest-opsgenie
```

## Usage

### Alert creation
Example:
```ruby
require 'buyerquest/opsgenie'

# Initialise client singleton
Buyerquest::Opsgenie::Client.init 'your-api-key-here'
# alternatively export OPSG_API_KEY to the runtime environment and then call without any arguments:
# Buyerquest::Opsgenie::Client.init

# Prepare alert object instance
test_alert = Buyerquest::Opsgenie::Alert.new(message: "I'm an alert from the buyerquest-opsgenie gem",
                                             alias: 'no-duplication',
                                             description: 'buyerquest-opsgenie gem alert')

# Fire alert
test_alert.create
```

### Heartbeat usage
```ruby
require 'buyerquest/opsgenie'

# Initialise client singleton
Buyerquest::Opsgenie::Client.init 'your-api-key-here'
# alternatively export OPSG_API_KEY to the runtime environment and then call without any arguments:
# Buyerquest::Opsgenie::Client.init

# Prepare alert object instance
test_heartbeat = Buyerquest::Opsgenie::Heartbeat.new(name: 'Test heartbeat')

# Start heartbeat
test_heartbeat.start
```

## Testing

Run `rake spec` to start the test suite.
