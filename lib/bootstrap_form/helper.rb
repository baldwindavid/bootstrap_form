module BootstrapForm
  module Helper
    def bootstrap_form_for(object, options = {}, &block)
      options[:builder] = BootstrapForm::FormBuilder

      layout = case options[:layout]
        when :inline
          "form-inline"
        when :horizontal
          "form-horizontal"
      end

      if layout
        options[:html] ||= {}
        options[:html][:class] = "#{options[:html][:class]} #{layout}".lstrip
      end

      temporarily_disable_field_error_proc do
        form_for(object, options, &block)
      end
    end

    def temporarily_disable_field_error_proc
      original_proc = ActionView::Base.field_error_proc
      ActionView::Base.field_error_proc = proc { |input, instance| input }
      yield
    ensure
      ActionView::Base.field_error_proc = original_proc
    end
  end
end
