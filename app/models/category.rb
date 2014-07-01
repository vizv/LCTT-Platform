class Category
  include Mongoid::Document

  field :name,                                    type: String # 文章名称
  field :description,                             type: String # 分类描述

  has_many :articles # 分类下属文档

  has_many   :sub_categories, class_name: 'Category', inverse_of: :super_category # 子分类
  belongs_to :super_category, class_name: 'Category', inverse_of: :sub_categories # 父分类

  def ancestor
    super_category && super_category.ancestor || self.to_s
  end

  def to_s
    super_category && "#{super_category.to_s} - #{description}" || description
  end
end
