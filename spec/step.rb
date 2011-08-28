require 'pinion/step'

describe Pinion::Step do
  let :step do
    Pinion::ProcStep.new {|xact| xact.visit() }
  end

  let :xact do
    mock("Transaction").tap do |x|
      x.should_receive(:visit)
      x.should_receive(:exceptions).and_return([])
    end
  end

  it "should return the next step" do
    nxt = mock("Step")
    step.next = nxt
    step.process(xact).should == nxt
  end

end
