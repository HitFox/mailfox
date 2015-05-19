Mailpimp::Engine.routes.draw do
  # resource :newsletters, only: :create
  post "/newsletters/create", to: "newsletters#create"
end
