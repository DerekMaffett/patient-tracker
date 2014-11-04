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
      puts json(response)
      expect(json(response)[:encounters].size).to eq 0
    end
  end
end
