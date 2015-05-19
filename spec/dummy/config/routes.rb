Rails.application.routes.draw do

  mount Mailpimp::Engine => "/mp"

  get 'main/index', to: 'main#index'
end
