class Role
  include Mongoid::Document
  
  field :name, :type => String

  has_and_belongs_to_many :users
  belongs_to :resource, :polymorphic => true

  index({ name: 1 }, { unique: true })
  index({ name: 1, resource_type: 1, resource_id: 1 }, { unique: true })
  
  scopify

  def self.roles
    {
      'translator'    => '译者',
      'proofreader'   => '校对',
      'publisher'     => '发布',
      'topicselector' => '选题',
      'admin'         => '管理',
    }
  end

  def to_s name
    self.class.roles[name]
  end
end
