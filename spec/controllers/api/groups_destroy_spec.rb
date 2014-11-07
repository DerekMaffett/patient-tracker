require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller do
  describe 'DELETE #destroy' do
    before(:each) do
      @group = create(:group)
    end

    context 'a user is not signed in' do
      it 'should raise an error' do
        expect { delete :destroy, id: @group }.to raise_error Pundit::NotAuthorizedError
      end

      it 'should not be deleted' do
        expect(Group.count).to eq 1
      end
    end
  end
end
