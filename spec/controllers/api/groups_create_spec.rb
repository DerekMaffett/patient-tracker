require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller do
  describe 'POST #create' do
    before(:each) do
      @data = {
        group: { name: 'Surgeons United' }
      }
    end

    context 'a user is not signed in' do
      it 'should raise an unauthorized user error' do
        expect { post :create, @data }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end
end
