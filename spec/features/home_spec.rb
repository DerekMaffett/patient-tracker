require 'rails_helper'

describe 'sign-in' do
  it 'registered users can sign in' do
    log_in_as :resident
    expect(page).to have_content('Signed in successfully')
  end
end
