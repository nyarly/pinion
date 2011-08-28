require 'pinion/transaction'
module Rack
  class AndRack
    def self.new(app, &block)
      require 'pinion/and-rack'
      and_rack = Pinion::AndRack.new(app)
      processor = Pinion::Chain.new(and_rack)
      and_pinion = AndPinion.new(processor)
      yield(processor)
      return and_pinion
    end
  end

  class AndPinion
    def initialize(processor)
      @processor = processor
    end

    def call(env)
      transaction = Pinion::Transaction.new(env)
      @processor.process(transaction)
      transaction.response.finish
    end
  end
end
