class ApplicationPolicy
  class NullUser
    def method_missing(method)
      false
    end
  end

  attr_reader :user, :record

  def initialize(user, record)
    @user = user || NullUser.new
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end

