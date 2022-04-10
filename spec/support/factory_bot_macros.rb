module FactoryBot::Syntax::Methods
  def nested_attributes_for(*args)
    attributes = attributes_for(*args)
    klass = args.first.to_s.camelize.constantize

    klass.reflect_on_all_associations(:belongs_to).each do |r|
      association = FactoryBot.create(r.class_name.underscore)
      attributes["#{r.name}_id".to_sym] = association.id
      attributes["#{r.name}_type".to_sym] = association.class.name if r.options[:polymorphic]
    end

    attributes
  end
end
