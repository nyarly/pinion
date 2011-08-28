require 'pinion/and-rack'

describe Pinion::AndRack do
  let :rack_app do
    proc {|env| 
      env["test-field"] = "set"
      [200, {}, ["Hello there!"]]
    }
  end

  let :and_rack do
    Pinion::AndRack.new(rack_app)
  end

  let :transaction do
    Pinion::Transaction.new(Rack::MockRequest.env_for("http://tst.com/"))
  end

  it "should run rack app" do
    transaction["test-field"].should_not == "set"
    and_rack.process(transaction)
    transaction["test-field"].should == "set"
    resp = transaction.rack_response
    resp[0].should == 200
    resp[1].should be_a(Hash)
    body = ""
    resp[2].each do |str|
      body << str
    end
    body.should == "Hello there!"
  end
  
end
