class User
  include Mongoid::Document
  # include Mongoid::Paranoia FIXME: deprecated
  include Mongoid::Timestamps::Created
  rolify

  field :uid,  type: String # GitHub UID
  field :name, type: String # 名字, 用于显示在作者栏

  has_many :articles # 用户翻译的文章 FIXME: Override 默认方法，提供归档和版本检索

  # attr_accessible :role_ids, as: :admin FIXME: ????
  # attr_accessible :uid, :name           FIXME: ????
  validates_presence_of :name

  def claimed_article
    Article.where(user: self, state: :translating).first
  end

  def claimed_article?
    !!claimed_article
  end

  def to_s
    name
  end
end
