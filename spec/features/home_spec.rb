require 'rails_helper'

describe 'sign-in' do
  before(:each) do
    @resident = create(:resident)
  end

  it 'registered users can sign in' do
    log_in_as @resident
    expect(page).to have_content('Signed in successfully')
  end
end
