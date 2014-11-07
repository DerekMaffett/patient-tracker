class Group < ActiveRecord::Base
  has_many :members, class_name: 'User'
  belongs_to :admin, class_name: 'User'

  validates :name, presence: true
end

