class User
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  rolify

  field :provider,                                type: String
  field :uid,                                     type: String
  field :name,                                    type: String

  attr_accessible :role_ids, :as => :admin
  attr_accessible :provider, :uid, :name
  validates_presence_of :name

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] || ""
      end
    end
  end

end
