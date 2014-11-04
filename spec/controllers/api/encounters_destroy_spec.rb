require 'rails_helper'

RSpec.describe Api::V1::EncountersController, type: :controller do
  describe 'DELETE #destroy' do
    describe 'deleting an encounter' do
      before(:each) do
        @resident = create(:resident)
        @encounter = create(:encounter, user_id: @resident.id)
      end

      context 'the resident who owns the encounters' do
        it 'should be deleted' do
          log_in_as @resident
          delete :destroy, id: @encounter
          expect(response).to have_http_status 204
          expect(Encounter.all).to_not include(@encounter)
        end
      end

      context 'a non-signed-in user' do
        it 'should not be deleted' do
          expect { delete :destroy, id: @encounter }
            .to raise_error Pundit::NotAuthorizedError
        end
      end

      context 'a different resident' do
        it 'should not be deleted' do
          @second_resident = create(:resident)
          log_in_as @second_resident
          expect { delete :destroy, id: @encounter }
            .to raise_error Pundit::NotAuthorizedError
        end
      end
    end
  end
end
