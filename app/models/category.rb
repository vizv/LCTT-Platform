class Category
  include Mongoid::Document

  field :name,                                    type: String # 文章名称
  field :descriptions,                            type: String # 分类描述

  has_many :articles # 分类下属文档
end
