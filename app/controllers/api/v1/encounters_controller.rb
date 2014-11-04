module Api
  module V1
    class EncountersController < Api::BaseController
      def index
        encounters = policy_scope(Encounter).includes(:user).order_name_and_time
        render json: encounters, status: 200
      end

      def create

      end

      def update

      end

      def destroy

      end
    end
  end
end
