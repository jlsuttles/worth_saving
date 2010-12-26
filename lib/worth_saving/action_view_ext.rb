module WorthSaving
  module ActionViewExt
    def self.included(base)
      base.extend(ClassMethods)
    end
  
    module ClassMethods
      def worth_saving_extra_action_view_methods
        include WorthSaving::ActionViewExt::InstanceMethods

        alias_method_chain :text_field, :worth_saving_check
        alias_method_chain :select, :worth_saving_check
        # alias_method_chain :text_area, :worth_saving_check
        # alias_method_chain :radio_field, :worth_saving_check
      end
    end
    
    module InstanceMethods
      def text_field_with_worth_saving_check(object_name, method, options = {})
        options.merge!({ 'data-draft' => true }) if object_name.camelize.constantize.worth_saving? && options.delete(:draft) != false
        text_field_without_worth_saving_check(object_name, method, options)
      end

      def select_with_worth_saving_check(object_name, method, choices, options = {}, html_options = {})
        html_options.merge!({ 'data-draft' => true }) if object_name.camelize.constantize.worth_saving? && options.delete(:draft) != false
        select_without_worth_saving_check(object_name, method, choices, options, html_options)
      end

    end
  
  end
end
ActionView::Base.send(:include, WorthSaving::ActionViewExt)
ActionView::Base.send(:worth_saving_extra_action_view_methods)