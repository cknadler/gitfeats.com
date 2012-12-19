module LoginHelpers 
  def mock_github_auth(user)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      :provider => 'github',
      :uid => user.uid,
      :info => {
        :nickname => user.nickname,
        :email => user.email
      },
      :credentials => {
        :token => user.token
      }
    )
  end

  def login(user)
    mock_github_auth(user)
    visit login_path
  end
end

RSpec.configure do |config|
  config.include LoginHelpers, :type => :request
end
