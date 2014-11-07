require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller do
  describe 'DELETE #destroy' do
    before(:each) do
      @group = create(:group)
      @resident = create(:resident)
    end

    context 'a user is not signed in' do
      it 'should raise an error' do
        expect { delete :destroy, id: @group }.to raise_error Pundit::NotAuthorizedError
      end

      it 'should not be deleted' do
        expect(Group.count).to eq 1
      end
    end

    context 'a non-admin resident is signed in' do
      before(:each) do
        log_in_as @resident
      end

      it 'should raise an error' do
        expect { delete :destroy, id: @group }.to raise_error Pundit::NotAuthorizedError
      end

      it 'should not be deleted' do
        expect(Group.count).to eq 1
      end
    end

    context 'a non-admin member of the group is signed in' do
      before(:each) do
        @resident.join @group
        log_in_as @resident
      end

      it 'should raise an error' do
        expect { delete :destroy, id: @group }.to raise_error Pundit::NotAuthorizedError
      end

      it 'should not be deleted' do
        expect(Group.count).to eq 1
      end
    end

    context 'the admin user is signed in' do
      before(:each) do
        @group.set_admin @resident
        log_in_as @resident
        delete :destroy, id: @group
      end

      it 'should return status 204' do
        expect(response).to have_http_status 204
      end

      it 'should delete the group' do
        expect(Group.count).to eq 0
      end
    end
  end
end
