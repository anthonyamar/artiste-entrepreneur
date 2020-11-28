class SlackNotifier
  
  def initialize
    @notifier = Slack::Notifier.new(ENV["slack_webhook_url"])
  end
  
  def perform(message)
    @notifier.ping(message)
  end
  
end