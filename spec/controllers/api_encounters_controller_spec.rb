require 'rails_helper'

RSpec.describe Api::EncountersController, :type => :controller do
  describe 'GET #index' do
    before(:each) do
      @resident = create(:resident)
    end
    it 'shows no encounters if resident has none' do
      log_in_as @resident
      get :index
      expect(response).to have_http_status(200)
      expect(json(response))[:encounters].size.to eq 0
    end
  end
end
