SimpleForm.setup do |config|
  config.wrappers :bootstrap, tag: 'div', class: 'form-group', error_class: 'has-error has-feedback' do |b|
    b.use :html5
    b.use :placeholder

    b.wrapper tag: 'div', class: 'input-group' do |ba|
      ba.use :label, :wrap_with => { tag: 'span', class: 'input-group-addon' }
      ba.use :input
      ba.use :error, :wrap_with => { tag: 'span', class: 'input-group-addon' }
    # ba.use :hint,  :wrap_with => { tag: 'p', class: 'help-block' }
    end
  end

  config.default_wrapper = :bootstrap
end
