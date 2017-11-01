Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'login', to: 'user#show'

  post 'login', to: 'user#check'

  get 'register', to: 'user#showRegister'

  post 'register', to: 'user#register'

  get 'profile', to: 'user#profile'

  get '/user/profile', to: 'user#fetch'

  get '/profile/:id', to: 'user#test'
end
