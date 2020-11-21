Rails.application.routes.draw do
  root 'static#home'
  
  get 'mentions-legales', to: 'static#legal', as: 'legal'
  get 'cgv', to: 'static#cgv', as: 'cgv'
  get 'typeform-success', to: 'static#typeform_success', as: 'typeform_success'
  
end
