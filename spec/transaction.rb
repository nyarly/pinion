require 'pinion/transaction'
require 'rack/mock'

describe Pinion::Transaction do
  let :transaction do
    Pinion::Transaction.new(Rack::MockRequest.env_for("http://www.example.com:8080/"))
  end
  
  it "should be able to store and retreive a value" do
    transaction.store("test", 1234)
    transaction.fetch("test").should == 1234
  end

  it "should provide a Hash for a Rack env" do
    transaction.rack_env.should be_a(Hash)
  end

  it "should provide an Array for a Rack response" do
    transaction.rack_response.should be_a(Array)

  end

end
