require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller do
  describe 'POST #join' do
    before(:each) do
      @group = create(:group)
    end

    context 'when the user is not signed in' do
      it 'should return a not authorized error' do
        expect { post :join, id: @group }.to raise_error Pundit::NotAuthorizedError
      end
    end


  end
end
