Rails.application.routes.draw do

  mount Mailfox::Engine => "/mp"

  get 'main/index', to: 'main#index'
end
