class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :members
  has_one :admin
end
