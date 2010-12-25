module WorthSaving
  module ActiveRecordExt
    def self.included(base)
      base.extend(ClassMethods)
    end
  
    module ClassMethods
      def worth_saving
        has_one :draft, :as => :record
      end
      
      def worth_saving?
        !reflect_on_all_associations.reject { |assoc| !(assoc.name == :draft && assoc.macro == :has_one) }.empty?
      end
    
      def worth_saving_extra_methods
        include WorthSaving::ActiveRecordExt::InstanceMethods
      end
    end
    
    module InstanceMethods
      def worth_saving?
        self.class.worth_saving?
      end
    end
  
  end
end
ActiveRecord::Base.send(:include, WorthSaving::ActiveRecordExt)
ActiveRecord::Base.send(:worth_saving_extra_methods)