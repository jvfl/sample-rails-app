Rails.application.routes.draw do

  #Modify default devise routes so they obey the test specs.
  devise_for :users, path: "/", path_names: { sign_in: 'login', sign_out: 'logout', confirmation: 'verification', registration: 'register', sign_up: "" }

  get '/home' => "user#index"
  root to: 'user#index'

end
