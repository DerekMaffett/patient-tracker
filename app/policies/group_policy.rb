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
    user.id
  end

  def create?
    user.id
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
