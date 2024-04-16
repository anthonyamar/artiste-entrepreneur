Rails.application.routes.draw do
  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unacceptable", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  root 'static#home'

  get 'mentions-legales', to: 'static#legal', as: 'legal'
  get 'cgv', to: 'static#cgv', as: 'cgv'
  get 'typeform-success', to: 'static#typeform_success', as: 'typeform_success'

  post 'full-program', to: 'messages#full_program', as: 'message_full_program'

  namespace :blog do
    resources :articles, only: [:index, :show, :create]
  end  

end
