class XlController < ApplicationController

def send_summary(email, name)
  UserMailer.create_SendSummary(email, name).deliver
  redirect_to :root
end
end