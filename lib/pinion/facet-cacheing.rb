module Pinion
  module FacetCacheing
    module ClassMethods
      def facet_group
        fg = FacetGroup.new{|g| yield(g) }
        fg.facet_methods do |name, proc|
          self.define_method(name, &proc)
        end
      end
    end

    def self.included(base) 
      base.extend(ClassMethods)
    end

    def clear_facets(*names)
      names.each do |name|
        self.instance_variable_set(name, nil)
      end
    end

    class FacetGroup
      def initialize
        @facets = {}
        yield(self)
      end

      def facet(named, &block)
        raise "Facet names should look like attributes (i.e. no =$)" if /=$/ =~ named
        @facets[named.to_s] = proc &block
      end

      def facet_methods
        all_names = @facets.keys
        @facets.each_pair do |name, block|
          other_names = (all_names - name).map do |name|
            ("@" + name).to_sym
          end

          read_block = proc do
            block.call()
            clear_facets(other_names)
          end
          yield(name, read_block)

          write_block = proc do |val|
            self.instance_variable_set(("@" + name).to_sym, val)
            clear_facets(other_names)
          end
          yield(name + "=", write_block)
        end
      end
    end
  end
end
