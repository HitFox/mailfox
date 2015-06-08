Mailpimp::Engine.routes.draw do
  # resource :newsletters, only: :create
  controller :newsletters do
    post "/newsletters", to: "newsletters#create", as: :newsletter_subscribe
  end
end
