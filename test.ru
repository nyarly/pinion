require 'rack/and-pinion'
require 'pinion/processor'
require 'pinion/step'

head = Pinion::Step.new do |transaction|
  transaction.response.write("A test")
end

processor = Pinion::Processor.new(head)

run Rack::AndPinion.new(processor)
