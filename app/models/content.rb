class Content
  include Mongoid::Document

  mount_uploader :body, ContentUploader
end
