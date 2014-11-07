require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller do
  describe 'GET #show' do
    before(:each) do
      @resident = create(:resident)
      @group = create(:group)
    end

    context 'when the user is not signed in' do
      it 'should raise an authorization error' do
        expect { get :show, id: @group.id }.to raise_error Pundit::NotAuthorizedError
      end
    end

    context 'when the user is a resident' do
      before(:each) do
        @resident.join @group
        log_in_as @resident
        get :show, id: @group.id
      end

      it 'should return 200 status' do
        expect(response).to have_http_status 200
      end

      it 'should show the requested group' do
        expect(json(response)[:group][:members].size).to eq 1
      end
    end
  end
end
