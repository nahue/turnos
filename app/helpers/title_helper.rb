module TitleHelper
  def page_title
    t page_title_translation_key,
     page_title_context.merge(:default => :"title.default.title")
     #"#{t :"title.default" }"
  end

  def section_title
    t :"title.#{controller_path}.#{action_name}.subtitle",
      page_title_context.merge(:default => :"title.default.subtitle")
  end

  def page_title_translation_key
    :"title.#{controller_path}.#{action_name}.title"
  end

  def page_title_context
    controller.view_assigns.symbolize_keys
  end
end
