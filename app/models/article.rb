class Article
  include Mongoid::Document

  field :title,                                   type: String # 原文标题（英文）
  field :source,                                  type: String # 文章来源
  field :source_url,                              type: String # 文章来源 URL
  field :license,                                 type: String # 许可信息（如: 无限制，CC BY-NC-SA 3.0，已经过作者授权，……）

  belongs_to :suggestion # 推荐源
  belongs_to :category   # 文章分类（默认无分类）

  has_one :original, class_name: 'Contact' # 原文（英文，MarkDown 格式）
  has_one :publish,  class_name: 'Contact' # 终稿（中文，HTML 格式）

  has_many :translations, class_name: 'Contact' # 译文（中文，MarkDown 格式）
  has_many :reversions,   class_name: 'Contact' # 校对稿（中文，MarkDown 格式）

  validates_presence_of :title
  validates_presence_of :category
end
