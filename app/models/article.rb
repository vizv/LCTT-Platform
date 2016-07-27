class Article
  include Mongoid::Document
  include Mongoid::Versioning
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  # Q: 为什么需要 suggestion？
  # A: 推荐可能摘录自一本书籍之类的，这种情况没有 source_url。
  #    当然，source_url 和 suggestion 有一个不为空就够了。
  # TODO: 将这段注释移动到 validator 部分

  field :title,       type: String # 原文标题（英文）
  field :source,      type: String # 文章来源
  field :source_url,  type: String # 文章来源 URL
  field :license,     type: String # 许可信息（如: 无限制，CC BY-NC-SA 3.0，已经过作者授权，……）
  field :suggestion,  type: String # 推荐稿（英文，任何格式）
  field :original,    type: String # 原文（英文，MarkDown 格式）
  field :translation, type: String # 译文（中文，MarkDown 格式）
  field :publish,     type: String # 终稿（中文，MarkDown 格式）
  field :state,       type: Symbol # 文章状态

  belongs_to :category # 文章分类（默认无分类）
  belongs_to :user     # 所属用户

  validates_presence_of :title, message: '原文标题不能为空'

  # 操作

  def claim user
    return false if self.state != :new

    self.user = user
    self.state = :translating

    self.save
  end

  def cancel_translate
    return if self.state != :translating
    self.user = new_owner
    self.state = :new
    self.save!
  end

  # 测试

  def archived?
    !!deleted_at
  end

  def is_suggest?
    self.state == :suggest
  end

  def is_new?
    self.state == :new
  end

  def is_translating?
    self.state == :translating
  end

  # 取值

  def all_versions
    a = self.versions
    a.push self.dup
  end

  def new_owner
    self.all_versions.group_by(&:state)[:new].first.user
  end

  def state_label
    case self.state
    when :suggest     then '新推荐'
    when :new         then '新原文'
    when :translating then '翻译中'
    when :translted   then '已翻译'
    when :done        then '已校对'
    end
  end

  def to_s
    archived? && "[#{state}-归档] #{title}" || "[#{state}] #{title}"
  end
end
