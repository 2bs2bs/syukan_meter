module LoginMacros
  def login(user)
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました！良い習慣を！'
  end
end
