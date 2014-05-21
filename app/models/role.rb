class Role
  include Mongoid::Document
  
  field :name, :type => String

  has_and_belongs_to_many :users
  belongs_to :resource, :polymorphic => true

  index(
    {
      :name => 1,
      :resource_type => 1,
      :resource_id => 1
    },
    { :unique => true}
  )
  
  scopify
end
