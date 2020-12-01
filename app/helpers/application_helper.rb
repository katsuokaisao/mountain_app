module ApplicationHelper
  def page_title(page_title)
    default_title = '百名山 '
    if page_title.present?
      "#{page_title} | #{default_title}"
    else
      default_title
    end
  end
end
