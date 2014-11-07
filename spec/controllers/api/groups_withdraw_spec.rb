require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller do
  describe 'POST #withdraw' do
    before(:each) do
      @group = create(:group)
      @resident = create(:resident)
      @resident.join @group
    end

    context 'when a non-signed-in user tries to withdraw from a group' do
      it 'should return a not authorized error' do
        expect { post :withdraw, id: @group }.to raise_error Pundit::NotAuthorizedError
      end
    end

    context 'when a signed-in resident tries to withdraw from a group' do
      before(:each) do
        log_in_as @resident
        post :withdraw, id: @group
      end

      it 'should return 200 status' do
        expect(response).to have_http_status 200
      end

      it 'should remove the resident from that group' do
        expect(@group.members).to_not include @resident
      end

      it 'should remove the group reference from the resident' do
        expect(@resident.reload.group).to be_nil
      end

      it 'should return the new group' do
        expect(json(response)[:group][:members]).to be_empty
      end
    end
  end
end
