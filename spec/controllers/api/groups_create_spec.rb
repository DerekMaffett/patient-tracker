require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller do
  describe 'POST #create' do
    before(:each) do
      @valid_data = {
        group: { name: 'Surgeons United' }
      }
    end

    context 'a user is not signed in' do
      it 'should raise an unauthorized user error' do
        expect { post :create, @valid_data }.to raise_error Pundit::NotAuthorizedError
      end
    end

    context 'a resident is signed in' do
      before(:each) do
        @resident = create(:resident)
        log_in_as @resident
      end

      context 'data is invalid' do
        before(:each) do
          post :create, { group: { name: '' } }
        end

        it 'should return a 422 error code' do
          expect(response).to have_http_status 422
        end

        it 'should not create a group' do
          expect(Group.count).to eq 0
        end
      end

      context 'data is valid' do
        before(:each) do
          post :create, @valid_data
        end

        it 'should return a 201 status code' do
          expect(response).to have_http_status 201
        end

        it 'should create a new group' do
          expect(Group.count).to eq 1
        end

        it 'should return the new group' do
          expect(json(response)[:group][:name]).to eq 'Surgeons United'
        end
      end
    end
  end
end
