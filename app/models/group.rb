class Group < ActiveRecord::Base
  has_many :members, dependent: :nullify, class_name: 'User'
  belongs_to :admin, class_name: 'User'

  validates :name, presence: true

  def set_admin(user)
    fail 'Only users can be admins' unless user.is_a? User
    update(admin_id: user.id)
  end
end

