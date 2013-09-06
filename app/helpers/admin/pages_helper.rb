module Admin::PagesHelper
  def nested_structure(pages)
    pages.map do |page, sub_pages|
      unless sub_pages.empty?
        render(page) + nested_structure(sub_pages)
      else
        render(page)
      end
    end.join.html_safe
  end
end
