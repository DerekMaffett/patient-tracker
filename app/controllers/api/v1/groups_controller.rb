module Api
  module V1
    class GroupsController < Api::BaseController
      def index
        groups = Group.all
        authorize groups
        render json: groups, status: 200
      end
    end
  end
end
