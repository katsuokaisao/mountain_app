module ApplicationHelper
  def page_title
    default_title = "100山" 
    if @title
      title = "#{@title} | #{default_title}" 
    else
      default_title
    end
  end
end
