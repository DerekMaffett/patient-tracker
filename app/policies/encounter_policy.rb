class EncounterPolicy < ApplicationPolicy
  class NullUser
    def method_missing(method)
      false
    end
  end

  attr_reader :user, :encounter

  def initialize(user, encounter)
    @user = user || NullUser.new
    @encounter = encounter
  end

  def index?
    user.role == 'Resident'
  end

  def show?
    index?
  end

  def new?
    create?
  end

  def create?
    user.role == 'Resident'
  end

  def edit?
    update?
  end

  def update?
    user.role == 'Resident' && user.id == encounter.user.id
  end

  def destroy?
    user.id == encounter.user.id
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
