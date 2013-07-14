OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  configure do |config|
      config.path_prefix = '/auth'
    end
  provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET']
  provider :twitter, ENV['TWITTER_ID'], ENV['TWITTER_SECRET']
end