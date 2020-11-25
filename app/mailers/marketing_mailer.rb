class MarketingMailer < ApplicationMailer
  
  def full_program(email)
    mail(to: email, subject: "Le programme Artiste Entrepreneur !")
  end
  
end
