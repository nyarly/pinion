require 'pinion/step'

module Pinion
  class AndRack < Step
    def initialize(app)
      @next = nil
      @app = app
    end

    def do_process(transaction)
      env = transaction.rack_env
      resp = @app.call(env)
      transaction.update_from_rack(env, resp)
    end
  end
end

