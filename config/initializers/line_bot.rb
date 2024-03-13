Rails.application.config.line_bot_client = Line::Bot::Client.new { |config|
  config.channel_secret = ENV["LINE_CHANNELSECRET"]
  config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
}  