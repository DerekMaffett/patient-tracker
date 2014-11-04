require 'rails_helper'

describe 'Make a successful payment' do
  before(:each) do
    @resident = create(:resident)
  end

  it 'tries to submit the payment form with valid test data' do
    log_in_as @resident
    visit new_charge_path
    # save_and_open_page
    click_on('span')
  end
end
