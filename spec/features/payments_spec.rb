require 'rails_helper'
require 'stripe_mock'

describe 'Test stripe for ' do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  it "creates a stripe customer" do
    customer = Stripe::Customer.create({
      email: 'johnny@appleseed.com',
      card: stripe_helper.generate_card_token
    })
    expect(customer.email).to eq('johnny@appleseed.com')
  end

  it "creates a stripe plan" do
    plan = stripe_helper.create_plan(:id => 'my_plan', :amount => 1500)
    expect(plan.id).to eq('my_plan')
    expect(plan.amount).to eq(1500)
  end

  it "deletes a stripe plan" do
    plan = stripe_helper.create_plan(:id => 'my_plan', :amount => 1500)
    stripe_helper.delete_plan(plan)
    expect(plan.id).to eq('my_plan')
    expect(plan.amount).to eq(1500)
  end

  it "generates a stripe card token" do
    card_token = StripeMock.generate_card_token(last4: "9191", exp_year: 1984)

    cus = Stripe::Customer.create(card: card_token)
    card = cus.cards.data.first
    expect(card.last4).to eq("9191")
    expect(card.exp_year).to eq(1984)
  end

  it "mocks a declined card error" do
  StripeMock.prepare_card_error(:card_declined)
  expect { Stripe::Charge.create }.to raise_error {|e|
    expect(e).to be_a Stripe::CardError
    expect(e.http_status).to eq(402)
    expect(e.code).to eq('card_declined')
    }
  end

  it "mocks an incorrect card number error" do
  StripeMock.prepare_card_error(:incorrect_number)
  expect { Stripe::Charge.create }.to raise_error {|e|
    expect(e).to be_a Stripe::CardError
    expect(e.http_status).to eq(402)
    expect(e.code).to eq('incorrect_number')
    }
  end

  it "mocks an invalid card number error" do
  StripeMock.prepare_card_error(:invalid_number)
  expect { Stripe::Charge.create }.to raise_error {|e|
    expect(e).to be_a Stripe::CardError
    expect(e.http_status).to eq(402)
    expect(e.code).to eq('invalid_number')
    }
  end

  it "mocks an expired card error" do
  StripeMock.prepare_card_error(:expired_card)
  expect { Stripe::Charge.create }.to raise_error {|e|
    expect(e).to be_a Stripe::CardError
    expect(e.http_status).to eq(402)
    expect(e.code).to eq('expired_card')
    }
  end

  it "mocks an invalid expiration month error" do
  StripeMock.prepare_card_error(:invalid_expiry_month)
  expect { Stripe::Charge.create }.to raise_error {|e|
    expect(e).to be_a Stripe::CardError
    expect(e.http_status).to eq(402)
    expect(e.code).to eq('invalid_expiry_month')
    }
  end

  it "mocks an invalid expiration year error" do
  StripeMock.prepare_card_error(:invalid_expiry_year)
  expect { Stripe::Charge.create }.to raise_error {|e|
    expect(e).to be_a Stripe::CardError
    expect(e.http_status).to eq(402)
    expect(e.code).to eq('invalid_expiry_year')
    }
  end

  it "mocks an invalid cvc error" do
  StripeMock.prepare_card_error(:invalid_cvc)
  expect { Stripe::Charge.create }.to raise_error {|e|
    expect(e).to be_a Stripe::CardError
    expect(e.http_status).to eq(402)
    expect(e.code).to eq('invalid_cvc')
    }
  end


  it "mocks an incorret cvc error" do
  StripeMock.prepare_card_error(:incorrect_cvc)
  expect { Stripe::Charge.create }.to raise_error {|e|
    expect(e).to be_a Stripe::CardError
    expect(e.http_status).to eq(402)
    expect(e.code).to eq('incorrect_cvc')
    }
  end

  it "mocks a card declined error" do
  StripeMock.prepare_card_error(:card_declined)
  expect { Stripe::Charge.create }.to raise_error {|e|
    expect(e).to be_a Stripe::CardError
    expect(e.http_status).to eq(402)
    expect(e.code).to eq('card_declined')
    }
  end

  it "mocks a card declined error" do
  StripeMock.prepare_card_error(:missing)
  expect { Stripe::Charge.create }.to raise_error {|e|
    expect(e).to be_a Stripe::CardError
    expect(e.http_status).to eq(402)
    expect(e.code).to eq('missing')
    }
  end

  it "mocks a card declined error" do
  StripeMock.prepare_card_error(:processing_error)
  expect { Stripe::Charge.create }.to raise_error {|e|
    expect(e).to be_a Stripe::CardError
    expect(e.http_status).to eq(402)
    expect(e.code).to eq('processing_error')
    }
  end

end
