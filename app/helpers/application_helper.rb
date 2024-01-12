module ApplicationHelper
  def page_title(page_title = '')
    base_title = '推しグッズギャラリー'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
