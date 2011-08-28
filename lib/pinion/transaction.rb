require 'rack/request'
require 'rack/response'

module Pinion
  class Transaction
    #TODO for tranaction
    #- bucket brigade body
    #- lifecycle hooks

    def initialize(rack_env)
      @env = rack_env
      @request = ::Rack::Request.new(@env)
      @response = ::Rack::Response.new
      @exceptions = []
      @store = {}
    end

    attr_reader :request, :response, :env, :exceptions

    #    include FacetCacheing
    #    facet_group do |g|
    #      g.facet("body") do
    #        dom.to_s
    #      end
    #
    #      g.facet("dom") do
    #        Nokogiri::HTML(body)
    #      end
    #    end
    #   Two big things need to be solved before this works:
    #   1. Modifications that aren't assignment (body.gsub!, etc)
    #   Could be as easy as "changed_body!" but it seems error prone
    #   One possible: only one version of a facet can have a value at a time
    #
    #   2. Composites.  Noteable: headers <= each header.
    #   Solution there might be that composites are always composite
    #   i.e. headers is the attr of the xact, and headers.accept_language etc
    #
    #
    def rack_env
      @env.clone
    end

    def update_request_from_rack(env)
      @env = env
      @request = ::Rack::Request.new(@env)
    end

    def update_response_from_rack(status, header, body)
      @response = ::Rack::Response.new(body, status, header)
    end

    def update_from_rack(env, resp)
      update_request_from_rack(env)

      status, header, body = *resp
      update_response_from_rack(status, header, body)
    end

    def rack_response
      response.finish
    end

    def [](k)
      @env[k]
    end
    alias :fetch :[]

    def []=(k,v)
      @env[k]=v
    end
    alias :store :[]=
  end
end
