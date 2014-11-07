require 'rails_helper'

describe 'Authentication' do
  before(:each) do
    @resident = create(:resident)
  end

  skip 'registered users can sign in' do
    log_in_as @resident
    expect(page).to have_content('Signed in successfully')
  end
end
