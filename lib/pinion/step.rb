module Pinion
  module StepMixin
    attr_accessor :next, :error_next

    def next_step(transaction)
      if transaction.exceptions.empty?
        return @next
      else
        return @error_next
      end
    end

    def process(transaction)
      do_process(transaction)
    rescue Object => ex
      transaction.exceptions << ex
    ensure
      return next_step(transaction)
    end
  end

  class Step
    include StepMixin

    def initialize()
      @next = nil
    end

    def do_process(transaction)
    end
  end

  class ProcStep < Step
    def initialize(&block)
      super()
      @proc = block
    end

    def do_process(transaction)
      @proc.call(transaction)
    end
  end
end
