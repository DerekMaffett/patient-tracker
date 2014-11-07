class User < ActiveRecord::Base
  # mount_uploader :avatar_image, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :encounters, dependent: :destroy
  belongs_to :group
  has_many :adminned_groups, class_name: 'Group', foreign_key: 'admin_id'

  before_save :set_default_name, :set_default_role

  def join(group)
    fail 'A user can only join groups' unless group.is_a? Group
    update(group_id: group.id)
  end

  private
    def set_default_name
      self.name = first_name + ' ' + last_name
    end

    def set_default_role
      self.role ||= 'Resident'
    end
end
