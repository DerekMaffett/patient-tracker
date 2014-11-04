module Api
  class EncountersController < ApplicationController
    def index
      encounters = Encounter.all.includes(:user).order(encountered_on: :desc)
      .order('users.name ASC')
    end

    def create

    end

    def update

    end

    def destroy

    end
  end
end
