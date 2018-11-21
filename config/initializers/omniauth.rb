# Make sure to get the email even if it's not public
opts = { scope: 'user:email' }

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], opts
end