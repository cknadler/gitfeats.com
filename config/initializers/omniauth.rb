Rails.application.config.middleware.use OmniAuth::Builder do
  file = YAML.load_file("config/git_secret.yml")
  secret = file["secret"] 
  id = file["id"]
  provider :github, id, secret
end
