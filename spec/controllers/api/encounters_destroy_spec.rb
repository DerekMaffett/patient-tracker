require 'rails_helper'

RSpec.describe Api::V1::EncountersController, type: :controller do
  describe 'DELETE #destroy' do
    describe 'when a resident deletes an encounter' do
      it 'should be deleted' do
        @resident = create(:resident)
        log_in_as @resident
        @encounter = create(:encounter, user_id: @resident.id)

        delete :destroy, id: @encounter
        expect(Encounter.all).to_not include(@encounter)
      end
    end
  end
end
