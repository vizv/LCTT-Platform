module MarkdownHelper
  # (延迟加载)并(缓存) (语法分析器)和(格式化器)
  def lexer
    @@lexer ||= Rouge::Lexers::Markdown.new css_class: 'highlight'
  end
  def formatter
    @@formatter ||= Rouge::Formatters::HTML.new
  end
end
