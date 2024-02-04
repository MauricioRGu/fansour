# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, "\\1en"
#   inflect.singular /^(ox)en/i, "\\1"
#   inflect.irregular "person", "people"
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym "RESTful"
# end

ActiveSupport::Inflector.inflections(:"pt-BR") do |inflect|
  inflect.plural(/$/, "s")
  inflect.plural(/^([a-zA-z]*)a$/i, '\1as')
  inflect.plural(/(s)$/i, '\1')
  inflect.plural(/^(paí)s$/i, '\1ses')
  inflect.plural(/(z|r)$/i, '\1es')
  inflect.plural(/al$/i,  "ais")
  inflect.plural(/el$/i,  "eis")
  inflect.plural(/ol$/i,  "ois")
  inflect.plural(/ul$/i,  "uis")
  inflect.plural(/([^aeiou])l$/i, '\1is')
  inflect.plural(/Mês/,'Meses')
end