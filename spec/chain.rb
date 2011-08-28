require 'pinion/chain'

describe Pinion::Chain do
  let :chain do
    Pinion::Chain.new(step_one)
  end

  let :step_one do
    (Pinion::ProcStep.new {|x| x[:list] << 1}).tap {|step| step.next = step_two}
  end

  let :step_two do
    (Pinion::ProcStep.new {|x| x[:list] << 2}).tap {|step| step.next = step_three}
  end

  let :step_three do
    Pinion::ProcStep.new {|x| x[:list] << 3}
  end

  it "should run through steps" do
    transaction = Pinion::Transaction.new({})
    transaction[:list] = []
    chain.process(transaction)
    transaction[:list].should == [1,2,3]
  end
end
