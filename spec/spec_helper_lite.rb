ENV['RAILS_ENV'] ||= 'test'
require 'minitest/autorun'
require 'rr'
require 'ostruct'

# ActiveRecord::Migration.maintain_test_schema! # to be delelted if the line below works
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

class MiniTest::Unit::TestCase
  # include RR::Adapters::MiniTest
end

def stub_module(full_name, &block)
  stub_class_or_module(full_name, Module)
end

def stub_class(full_name, &block)
  stub_class_or_module(full_name, Class)
end

def stub_class_or_module(full_name, kind, &block)
  full_name.to_s.split(/::/).inject(Object) do |context, name|
    begin
      context.const_get(name)
    rescue NameError
      context.const_set(name, kind.new)
    end
  end
end

module SpecHelpers
  def setup_nulldb
    if Object.const_defined?(:ActiveRecord)
      unless ActiveRecord::Base.connected?
        unless Object.const_defined?(:Rails)
          Object.const_set(:Rails, Module.new)        
        end
        unless Rails.respond_to?(:root)
          def Rails.root
            File.expand_path('..', File.dirname(__FILE__))
          end
        end
        @old_ar_cxn = ActiveRecord::Base.connection_pool.spec
        ActiveRecord::Base.establish_connection :adapter => :nulldb
      end
    end
  end
 
  def teardown_nulldb
    ActiveRecord::Base.establish_connection(@old_ar_cxn)
  end
end