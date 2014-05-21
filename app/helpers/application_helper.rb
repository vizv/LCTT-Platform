module ApplicationHelper
  def set_title(page_title)
    content_for(:title){ page_title }
    page_title
  end

  def project_name
    'Linux 中国翻译平台'
  end
end
