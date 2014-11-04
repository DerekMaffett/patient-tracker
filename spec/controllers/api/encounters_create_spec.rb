require 'rails_helper'

RSpec.describe Api::V1::EncountersController, type: :controller do
  describe 'POST #create' do
    before(:each) do
      @resident = create(:resident)
      @data = {
        encountered_on: Date.today,
        encounter_types: {},
      }
      Encounter::TYPES.each do |type|
        @data[:encounter_types][type] = 2
      end
    end

    context 'when submitting data for multiple categories' do
      it 'should create all records' do
        log_in_as @resident
        post :create, @data
        expect(response).to have_http_status 201
        expect(@resident.encounters.count).to eq Encounter::TYPES.size * 2
        expect(json(response)[:encounters].size).to eq Encounter::TYPES.size * 2
      end
    end

    context 'when submitting invalid data' do
      it 'should not save or return data' do
        @data[:encountered_on] = 'invalid'
        log_in_as @resident
        post :create, @data
        expect(response).to have_http_status 422
        expect(@resident.encounters.count).to eq 0
        expect(json(response)[:encounters])
          .to eq ["Validation failed: Encountered on can't be blank"]
      end
    end

    context 'when submitting data while not signed in' do
      it 'should not save or return data' do
        expect { post :create, @data }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end
end
