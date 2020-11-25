# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

if Rails.env.production?

	ActionMailer::Base.smtp_settings = {
		:user_name => ENV['SENDGRID_USERNAME'],
		:password => ENV['SENDGRID_PASSWORD'],
		:domain => 'https://artiste-entrepreneur.herokuapp.com',
		:address => 'smtp.sendgrid.net',
		:port => 587,
		:authentication => :plain,
		:enable_starttls_auto => true
	}
	
elsif Rails.env.development?
	
	ActionMailer::Base.smtp_settings = {
		:address => "localhost",
    :port => 1025
		}
		
	ActionMailer::Base.default_url_options = { :host => "localhost:3000" }
	
end
