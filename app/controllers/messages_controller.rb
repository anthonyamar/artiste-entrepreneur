class MessagesController < ApplicationController
  
  def full_program
    @email = full_program_params[:email]
    
    if MailChecker.valid?(@email)
      save_email_to_hubspot(@email)
      render json: "Ok", status: 200
    else
      render json: "Le domaine #{@email.partition('@').last if email} n'est pas autorisé", status: 401
    end
  end
  
  private
  
  def save_email_to_hubspot(email)
    
  end
  
  def full_program_params
    params.require(:full_program).permit(:email)
  end
  
end
