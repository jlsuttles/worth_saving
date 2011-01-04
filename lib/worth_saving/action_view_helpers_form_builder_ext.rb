module WorthSaving
  module FormBuilderExt
    # def self.included(base)
    #   base.extend(ClassMethods)
    # end
    # 
    # module ClassMethods
    #   def worth_saving_action_view_helpers_form_builder_extra_methods
    #     include WorthSaving::FormBuilderExt::InstanceMethods
    #   end
    # end
    # 
    module InstanceMethods
      def draft_message(*args)
        "This shit has a draft yo"
      end    
    end
  end
end
# ActionView::Helpers::FormBuilder.send(:include, WorthSaving::FormBuilderExt)
# ActionView::Helpers::FormBuilder.send(:worth_saving_action_view_helpers_form_builder_extra_methods)
ActionView::Helpers::FormBuilder.send(:include, WorthSaving::FormBuilderExt::InstanceMethods)