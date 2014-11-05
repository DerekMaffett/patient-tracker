class Group < ActiveRecord::Base
  has_one :admin
  has_many :users
end

