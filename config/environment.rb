# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

if Rails.env.production?

  ActionMailer::Base.smtp_settings = {
    :port           => ENV['MAILGUN_SMTP_PORT'],
    :address        => ENV['MAILGUN_SMTP_SERVER'],
    :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
    :password       => ENV['MAILGUN_SMTP_PASSWORD'],
    :domain         => 'artiste-entrepreneur.com',
    :authentication => :plain,
  }
  ActionMailer::Base.delivery_method = :smtp


elsif Rails.env.development?

  ActionMailer::Base.smtp_settings = {
    :address => "localhost",
    :port => 1025
    }

  ActionMailer::Base.default_url_options = { :host => "localhost:3000" }

end
