# from Demetrio Nunes
# Modified by Andy Singleton to use different GUID generator
#
# MIT License

require 'uuid22'

module ActiveRecord
  module Usesguid #:nodoc:
  
    def self.append_features(base)
      super
      base.extend(ClassMethods)  
    end

    
    module ClassMethods
      
      def usesguid(options = {})
                
        class_eval do
          set_primary_key options[:column] if options[:column]
          
          def after_initialize
            self.id ||= UUID.timestamp_create().to_s22
          end
        end        
        
      end
      
    end
  end
end

ActiveRecord::Base.class_eval do
  include ActiveRecord::Usesguid
end