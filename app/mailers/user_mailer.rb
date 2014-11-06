class UserMailer < ActionMailer::Base
  default from: 'notifications@example.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user, subject: 'Welcome to My Awesome Site')
=begin
    encoded_content = SpecialEncode(File.read('/encounters/summary.xls'))
    attachments['summary.xls'] = {mime_type: 'application/x-gzip',
                                   encoding: 'SpecialEncoding',
                                   content: encoded_content }
=end
  end
end