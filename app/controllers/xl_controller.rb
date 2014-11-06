class XlController < ApplicationController

def welcome_email(email, name)
  UserMailer.create_welcome_email(email, name).deliver
  redirect_to :root
end
end