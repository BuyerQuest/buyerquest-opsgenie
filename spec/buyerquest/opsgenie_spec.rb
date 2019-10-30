RSpec.describe Buyerquest::Opsgenie do
  it "has a version number" do
    expect(Buyerquest::Opsgenie::VERSION).not_to be nil
  end
end


RSpec.describe Buyerquest::Opsgenie::Client do
  it "have authorization header" do
    expect(Buyerquest::Opsgenie::Client.get_headers('').keys.length).to be >= 1
    expect(Buyerquest::Opsgenie::Client.get_headers('').keys).to include :Authorization
  end

  it "uses correct headers for GET" do
    expect(Buyerquest::Opsgenie::Client.get_headers('GET').keys.length).to be 1
  end

  it "uses correct headers for POST" do
    expect(Buyerquest::Opsgenie::Client.get_headers('POST').keys.length).to be 2
    expect(Buyerquest::Opsgenie::Client.get_headers('POST').keys).to include :content_type
  end

  it "uses correct headers for PATCH" do
    expect(Buyerquest::Opsgenie::Client.get_headers('PATCH').keys.length).to be 2
    expect(Buyerquest::Opsgenie::Client.get_headers('PATCH').keys).to include :content_type
  end

  it "Fails when HTTP method incorrect" do
    expect{ Buyerquest::Opsgenie::Client.execute({method: 'GET1', uri: '/'}) }.to raise_error(RuntimeError, '[OpsGenie Error] Unknown method')
  end
end

heartbeat_mock = {
    name: 'Test heartbeat'
}

RSpec.describe Buyerquest::Opsgenie::Heartbeat do
  it "heartbeat name is correct" do
    expect((Buyerquest::Opsgenie::Heartbeat.new(heartbeat_mock)).name ).to match 'Test heartbeat'
  end
end