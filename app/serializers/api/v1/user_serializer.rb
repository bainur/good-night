class Api::V1::UserSerializer
  include JSONAPI::Serializer

  attributes :name, :id
  has_many :sleep_records

  has_many :follows, serializer: Api::V1::FollowSerializer

  attribute :followers do |object|
    object.followed_users
  end
end