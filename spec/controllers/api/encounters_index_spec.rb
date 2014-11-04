require 'rails_helper'

RSpec.describe Api::V1::EncountersController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      @resident = create(:resident)
    end

    it 'shows no encounters if resident has none' do
      log_in_as @resident
      get :index
      expect(response).to have_http_status 200
      expect(json(response)[:encounters].size).to eq 0
    end

    describe 'when multiple residents are using the app' do
      it 'should only show encounters for the individual residents' do
        @second_resident = create(:resident)
        create(:encounter, user_id: @second_resident.id)
        log_in_as @resident
        get :index

        expect(response).to have_http_status 200
        expect(json(response)[:encounters].size).to eq 0
      end
    end

    describe 'when a resident has multiple encounters' do
      before(:each) do
        2.times { create(:encounter, user_id: @resident.id) }
        log_in_as @resident
        get :index
      end

      it 'should have a 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should have a size equal to the number of records' do
        expect(json(response)[:encounters].size).to eq 2
      end

      it 'should list the date encountered' do
        expect(json(response)[:encounters][0][:encountered_on].to_date)
          .to be_between Date.today - 30.days, Date.today
      end

      it 'should list a custom submitted_on attr as the submission time' do
        expect(json(response)[:encounters][0][:submitted_on].to_date)
          .to eq Date.today
      end

      it "should give the associated user's name" do
        expect(json(response)[:encounters][0][:user][:name])
          .to eq @resident.name
      end

      it 'should not return parameters such as password' do
        expect(json(response)[:encounters][0][:user][:encrypted_password])
          .to be_nil
      end
    end
  end
end
