Rails.application.routes.draw do
  # hay una manera mas optima de colocar todas las rutas de productos seria esta 
  #resources :products # de esta forma quedarai todas las urls de productos 
  
  # si uno quiere que alguna vista sea la principal de home seria de la siguiente forma 
  resources :categories, except: :show #quitamos la vista show
  resources :products, path: "/"

=begin get "up" => "rails/health#show", as: :rails_health_check
  # rutas integradas
  delete "/products/:id", to: "products#destroy"
  patch "/products/:id", to: "products#update"
  post "/products", to: "products#create"
  get "/products/new", to: "products#new", as: :new_product
  get "/products", to: "products#index" # cuando alguien haga una peticion a index devolvemos la lista de productos
  get "/products/:id", to: "products#show", as: :product # para recibir un producto se coloca as: :nombre del path
  get "/products/:id/edit", to: "products#edit", as: :edit_product #metodo helper
=end
  
end
