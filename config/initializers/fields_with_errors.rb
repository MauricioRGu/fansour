#procedure é disparada sempre que algum campo é invalidado nas validações do model
ActionView::Base.field_error_proc = proc do |html_tag, instance|
  html_doc = Nokogiri::HTML::DocumentFragment.parse(html_tag, Encoding::UTF_8.to_s)
  element = html_doc.children[0]
  if element
      if %w[input select textarea].include? element.name
        element.add_class('is-invalid')
        instance.raw %(#{html_doc.to_html} <div class="invalid-feedback">#{[*instance.error_message].to_sentence}</div>)
      else
          instance.raw html_doc.to_html
      end
  else
      html_tag
  end
end