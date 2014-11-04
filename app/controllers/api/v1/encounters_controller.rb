module Api
  class EncountersController < ApplicationController
    def index
      encounters = policy_scope(Encounter).includes(:user).order_name_and_time
    end

    def create

    end

    def update

    end

    def destroy

    end
  end
end
