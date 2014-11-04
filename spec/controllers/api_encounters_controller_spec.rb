require 'rails_helper'

RSpec.describe Api::V1::EncountersController, :type => :controller do
  describe 'GET #index' do
    before(:each) do
      @resident = create(:resident)
    end

    it 'shows no encounters if resident has none' do
      log_in_as @resident
      get :index
      expect(response).to have_http_status(200)
      expect(json(response)[:encounters].size).to eq 0
    end

    describe 'when a resident has multiple encounters' do
      before(:each) do
        2.times { create(:encounter, user_id: @resident.id) }
      end

      it 'shows encounters of a resident' do
        log_in_as @resident
        get :index
        expect(response).to have_http_status(200)
        expect(json(response)[:encounters].size).to eq 2
        expect(json(response)[:encounters][0][:encountered_on].to_date)
          .to be_between Date.today - 30.days, Date.today
        expect(json(response)[:encounters][0][:submitted_on].to_date)
          .to eq Date.today
        expect(json(response)[:encounters][0][:user][:name])
          .to eq @resident.name
        expect(json(response)[:encounters][0][:user][:encrypted_password])
          .to be_nil
      end
    end
  end
end
