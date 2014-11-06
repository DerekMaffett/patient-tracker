module Api
  module V1
    class EncountersController < Api::BaseController
      def index
        encounters = policy_scope(Encounter).includes(:user).order_name_and_time
        render json: encounters, status: 200
      end

      def create
        authorize Encounter.new(user_id: current_user.try(:id))
        encounters = []
        begin
          ActiveRecord::Base.transaction do
            encounter_types.each do |type, number|
              number.to_i.times  do
                encounters.push Encounter.create!(
                  encounter_type: type.to_s.humanize(capitalize: false),
                  encountered_on: encountered_on,
                  user: current_user
                )
              end
            end
          end
        rescue ActiveRecord::ActiveRecordError => error
          logger.error "Error in EncountersController#create: #{error.message}"
          return render json: [error.message], status: 422
        end

        render json: encounters, status: 201
      end

      def destroy
        encounter = Encounter.find(params[:id])
        authorize encounter
        encounter.destroy
        render nothing: true, status: 204
      end

      private

      def encounter_params
        params.require(:encounter).permit(:encounter_type)
      end

      def encountered_on
        params.require(:encountered_on)
      end

      def encounter_types
        params.require(:encounter_types).permit(*Encounter::TYPES)
      end
    end
  end
end
