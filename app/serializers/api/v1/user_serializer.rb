class Api::V1::UserSerializer
  include JSONAPI::Serializer

  attributes :name, :id
  has_many :sleep_records

  attributes :follows do |object|
    object.follows
  end

  attribute :followers do |object|
    object.followed_users
  end
end