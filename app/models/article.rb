class Article
  include Mongoid::Document
  include Mongoid::Versioning
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :title,                                   type: String # 原文标题（英文）
  field :source,                                  type: String # 文章来源
  field :source_url,                              type: String # 文章来源 URL
  field :license,                                 type: String # 许可信息（如: 无限制，CC BY-NC-SA 3.0，已经过作者授权，……）
  field :suggestion,                              type: String # 推荐稿（英文，任何格式）
  field :original,                                type: String # 原文（英文，MarkDown 格式）
  field :translation,                             type: String # 译文（中文，MarkDown 格式）
  field :publish,                                 type: String # 终稿（中文，HTML 格式）
  field :state,                                   type: Symbol # 文章状态

  belongs_to :category # 文章分类（默认无分类）
  belongs_to :user     # 所属用户

  validates_presence_of :title

  def archived?
    !!deleted_at
  end

  def state
    case self[:state]
    when :suggest     then '新推荐'
    when :new         then '新原文'
    when :translating then '翻译中'
    when :translted   then '已翻译'
    when :proofread   then '已校对'
    when :published   then '已发布'
    end
  end

  def to_s
    archived? && "[#{state}-归档] #{title}" || "[#{state}] #{title}"
  end
end
