class Suggestion
  include Mongoid::Document

  field :title,                                   type: String # 见 Article
  field :source,                                  type: String # 见 Article
  field :source_url,                              type: String # 见 Article
  field :license,                                 type: String # 见 Article

  has_one :content # 推荐内容（仅在来源不可用时需提供）
end
