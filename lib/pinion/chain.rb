module Pinion
  class Chain
    def initialize(head = nil, tail = nil)
      @head = head
      @tail = tail || head
      @error_step = nil
    end

    attr_reader :head, :tail
    attr_accessor :error_step

    def prepend(step)
      old_head = @head
      @head = step
      step.next = old_head
      step.error_next = @error_step
      return step
    end

    def append(step)
      if @tail
        @tail.next = step
        @tail = @tail.next
      else
        if @head
          @tail = @head.next
          while @tail.next
            @tail = @tail.next
          end
          @tail.next = step
        else
          @head = step
          @tail = step
        end
      end
      step.error_next = @error_step
      return step
    end

    def postfix_with(other)
      @tail.next = other.head
      @tail = other.tail
      return self
    end

    def prefix_with(other)
      other.tail.next = @head
      @head = other.head
      return self
    end

    #TODO: transaction should drive this
    def process(transaction)
      step = @head
      while(step)
        step = step.process(transaction)
      end
    end
  end
end
