class GroupPolicy < ApplicationPolicy
  class NullUser
    def method_missing(method)
      false
    end
  end

  attr_reader :user, :group

  def initialize(user, group)
    @user = user || NullUser.new
    @group = group
  end

  def index?
    @user.role == 'Resident'
  end

  def create?
    @user.role == 'Resident'
  end

  def join?
    @user.role == 'Resident'
  end

  def withdraw?
    @user.role == 'Resident'
  end

  def destroy?
    @user == @group.admin
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
