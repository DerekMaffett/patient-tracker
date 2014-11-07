require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller do
  describe 'POST #join' do
    before(:each) do
      @resident = create(:resident)
      @group = create(:group)
    end

    context 'when a non-signed-in user tries to join a group' do
      it 'should return a not authorized error' do
        expect { post :join, id: @group }.to raise_error Pundit::NotAuthorizedError
      end
    end

    context 'when a signed-in resident tries to join a group' do
      before(:each) do
        log_in_as @resident
        post :join, id: @group
      end

      it 'should return 200 status' do
        expect(response).to have_http_status 200
      end

      it 'should enroll the resident in that group' do
        expect(@resident.reload.group).to eq @group
      end

      it 'should update the group' do
        expect(@group.members).to include @resident
      end

      it 'should return the new group membership' do
        expect(json(response)[:groups][0][:members][0][:name]).to eq @resident.name
      end
    end
  end
end
