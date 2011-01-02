module WorthSaving
  module ActionViewExt
    def self.included(base)
      base.extend(ClassMethods)
    end
  
    module ClassMethods
      def worth_saving_extra_action_view_methods
        
        # def setup_options!, given the ! not because it changes the caller but b/c it changes the arguments (options)
        # The two separate options arrays are the same except in the case of the 'select' field builder, which has
        #     html_options for HTML attrs rather than using the options hash like the other field builders
        def setup_options!(object_name, field_name, in_options, out_options = nil)
          out_options ||= in_options
          object_id = in_options[:object] && in_options[:object].to_param
          record_type = object_name.to_s.camelize
          if record_type.constantize.worth_saving? && in_options.delete(:draft) != false
            out_options.merge!({ 'data-record_type' => record_type, 
              'data-record_id' => object_id.to_s, 'data-record_field' => field_name })
          end
        end

        include WorthSaving::ActionViewExt::InstanceMethods

        alias_method_chain :text_field, :worth_saving_check
        alias_method_chain :select, :worth_saving_check
        alias_method_chain :check_box, :worth_saving_check
        alias_method_chain :text_area, :worth_saving_check
        alias_method_chain :radio_button, :worth_saving_check
        
      #### Unspec'd as of now
        # alias_method_chain :form_for, :worth_saving_check
      end
    end
    
    # All of these <something>_with_worth... methods will have a .to_s after object_name.  That should be put into the spec
    #    so nobody ever fucks it up.  It passes specs without it unless using the method without being inside a form_for block
    module InstanceMethods
      
      def text_field_with_worth_saving_check(object_name, method, options = {})
        ActionView::Base.setup_options!(object_name, method, options)
        text_field_without_worth_saving_check(object_name, method, options)
      end

      def select_with_worth_saving_check(object_name, method, choices, options = {}, html_options = {})
        ActionView::Base.setup_options!(object_name, method, options, html_options)
        select_without_worth_saving_check(object_name, method, choices, options, html_options)
      end

      def check_box_with_worth_saving_check(object_name, method, options = {}, checked_value = "1", unchecked_value = "0")
        ActionView::Base.setup_options!(object_name, method, options)
        check_box_without_worth_saving_check(object_name, method, options, checked_value, unchecked_value)
      end

      def text_area_with_worth_saving_check(object_name, method, options = {})
        ActionView::Base.setup_options!(object_name, method, options)
        text_area_without_worth_saving_check(object_name, method, options)
      end

      def radio_button_with_worth_saving_check(object_name, method, tag_value, options = {})
        ActionView::Base.setup_options!(object_name, method, options)
        radio_button_without_worth_saving_check(object_name, method, tag_value, options)
      end
      
      # def form_for_with_worth_saving_check(record_or_name_or_array, *args, &proc)
      #   options.merge!({ 'data-draft' => object_name }) if object_name.camelize.constantize.worth_saving?
      #   form_for_without_worth_saving_check(record_or_name_or_array, *args, &proc)
      # end

    end
  
  end
end
ActionView::Base.send(:include, WorthSaving::ActionViewExt)
ActionView::Base.send(:worth_saving_extra_action_view_methods)