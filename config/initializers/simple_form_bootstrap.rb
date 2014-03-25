inputs = %w[
  CollectionSelectInput
  DateTimeInput
  FileInput
  GroupedCollectionSelectInput
  NumericInput
  PasswordInput
  RangeInput
  StringInput
  TextInput
]

inputs.each do |input_type|
  superclass = "SimpleForm::Inputs::#{input_type}".constantize

  new_class = Class.new(superclass) do
    def input_html_classes
      super.push('form-control')
    end
  end

  Object.const_set(input_type, new_class)
end

# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.boolean_style = :nested

  config.wrappers :bootstrap3, tag: 'div', class: 'form-group', error_class: 'has-error',
      defaults: { input_html: { class: 'default_class' } } do |b|

    b.use :html5
    b.use :min_max
    b.use :maxlength
    b.use :placeholder

    b.optional :pattern
    b.optional :readonly

    b.use :label_input
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
    b.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
  end

  config.wrappers :bootstrap_login, tag: :div, class: 'form-group', error_class: 'has-error' do |b|


    b.wrapper :col, :tag => :div, :class => "col-xs-12" do |col|
      col.wrapper "input_group", :tag => :div, :class => "input-group" do |ig|
        ig.use :html5
        ig.use :maxlength
        ig.use :placeholder

        ig.optional :pattern
        ig.optional :readonly

        #<span class="input-group-addon"><i class="gi gi-envelope"></i></span>
        ig.wrapper tag: :span, class: 'input-group-addon' do |span|
          span.wrapper 'icon', tag: 'i', class: 'gi' do |i|
          end
        end
        ig.use :input

      end
      #col.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      #col.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
    end
  end

  config.wrappers :prepend, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.wrapper tag: 'div', class: 'controls' do |input|
      input.wrapper tag: 'div', class: 'input-group' do |prepend|
    prepend.use :label , class: 'input-group-addon' ###Please note setting class here fro the label does not currently work (let me know if you know a workaround as this is the final hurdle)
        prepend.use :input
      end
      input.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      input.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
    end
  end

  config.wrappers :append, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.wrapper tag: 'div', class: 'controls' do |input|
      input.wrapper tag: 'div', class: 'input-group' do |prepend|
        prepend.use :input
    prepend.use :label , class: 'input-group-addon' ###Please note setting class here fro the label does not currently work (let me know if you know a workaround as this is the final hurdle)
      end
      input.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      input.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
    end
  end

  config.wrappers :checkbox, tag: :div, class: "checkbox", error_class: "has-error" do |b|

    # Form extensions
    b.use :html5

    # Form components
    b.wrapper tag: :label do |ba|
      ba.use :input
      ba.use :label_text
    end

    b.use :hint,  wrap_with: { tag: :p, class: "help-block" }
    b.use :error, wrap_with: { tag: :span, class: "help-block text-danger" }
  end

  config.wrappers :checkbox2, tag: false,  error_class: "has-error" do |b|

    # Form extensions
    b.use :html5

    b.wrapper "switch", tag: :label, :class => "switch switch-primary" do |ba|
      ba.use :input

      ba.use :hint,  wrap_with: { tag: :p, class: "help-block" }
      ba.use :error, wrap_with: { tag: :span, class: "help-block text-danger" }

      ba.wrapper tag: :span do |span|
      end
    end
  end
  config.wrappers :inline_checkbox, :tag => :label, class: "switch switch-primary", :error_class => 'has-error' do |b|
    b.use :html5
    b.use :input
    b.wrapper tag: :span do |span|
    end
  end
  # Wrappers for forms and inputs using the Twitter Bootstrap toolkit.
  # Check the Bootstrap docs (http://getbootstrap.com/)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :bootstrap3
end
