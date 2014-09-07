class Bootstrap3FormBuilder < Padrino::Helpers::FormBuilder::StandardFormBuilder
  def has_error(field)
    error = @object.errors[field] if @object.respond_to?(:errors)
    "has-error" unless error.blank?
  end
end
