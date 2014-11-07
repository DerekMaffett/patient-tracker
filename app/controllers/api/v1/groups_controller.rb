module Api
  module V1
    class GroupsController < Api::BaseController
      def index
        groups = Group.all
        authorize groups
        render json: groups, status: 200
      end

      def create
        group = Group.new(group_params)
        group.admin = current_user
        authorize group
        if group.save
          render json: group, status: 201
        else
          render json: group.errors, status: 422
        end
      end

      def destroy
        group = Group.find(params[:id])
        authorize group
        group.destroy
        render nothing: true, status: 204
      end

      private

      def group_params
        params.require(:group).permit(:name)
      end
    end
  end
end
