class StaticController < ApplicationController
  
  def home
    @courses = I18n.t("courses")
    @message = Message.new
  end
  
  def legal
  end
  
  def cgv
  end
  
  def typeform_success
  end
  
end
