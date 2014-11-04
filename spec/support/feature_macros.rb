module FeatureMacros
  def log_in_as(user)
    visit '/'
    click_on 'sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password',
      with: (user.role == 'admin' ? 'admin' : 'resident')
    click_on 'Sign in'
  end
end
