class UserSerializer < ActiveModel::Serializer
  attributes :neo_id, :email, :username, :auth_code, :team_id
end