require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller do
  describe 'GET #index' do
    context 'when the user is not signed in' do
      it 'should raise an authorization error' do
        expect { get :index }.to raise_error Pundit::NotAuthorizedError
      end
    end
    context 'when the user is a resident' do
      before(:each) do
        @resident = create(:resident)
      end

      context 'when there are no groups' do
        it 'should give an empty response' do
          log_in_as @resident
          get :index
          expect(response).to have_http_status 200
          expect(json(response)[:groups]).to be_empty
        end
      end
    end
    context
  end
end
