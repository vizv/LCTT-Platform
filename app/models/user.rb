class User
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps::Created
  rolify

  field :uid,                                     type: String # GitHub UID
  field :name,                                    type: String # 名字

  has_many :articles # 用户翻译的文章 FIXME: Override 默认方法，提供归档和版本检索

  attr_accessible :role_ids, :as => :admin
  attr_accessible :uid, :name
  validates_presence_of :name

  def current_translating
     Article.where(user: self, state: :translating).first
  end

  def to_s
    name
  end
end
