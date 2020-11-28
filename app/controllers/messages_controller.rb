class MessagesController < ApplicationController
  
  def full_program
    @email = full_program_params[:email]
    
    if MailChecker.valid?(@email)
      MarketingMailer.full_program(@email).deliver
      save_email_to_hubspot(@email) if Rails.env.production?
      SlackNotifier.new.perform("💌 Programme envoyé à #{@email} et fiche contact créée sur HubSpot 👌")
      render json: "Programme envoyé", status: 200
    else
      render json: "Le domaine #{@email.partition('@').last if email} n'est pas autorisé", status: 401
    end
  end
  
  private
  
  def save_email_to_hubspot(email)
    formated_date = Date.today.strftime("%Q").to_i rescue 0
    properties = { 
      download_program_at: formated_date, 
      hs_lead_status: "OPEN" 
    }

    begin
      Hubspot::Contact.create!(email, properties)
    rescue
      Hubspot::Contact.find_by_email(email).update!(properties)
    end
  end
  
  def full_program_params
    params.require(:full_program).permit(:email)
  end
  
end
