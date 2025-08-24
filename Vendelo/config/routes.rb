Rails.application.routes.draw do
  # ruta para la autenticacion
  # le quita el name spaces
  namespace :authentication, path: "", as: "" do # se colocara el path y el as para quitar el colocar la ruta completa como /autheticantion/users/new
    resources :users, only: [ :new, :create ], path: "/register", path_names: { new: "/" }
    resources :sessions, only: [ :new, :create, :destroy ], path: "/login", path_names: { new: "/" }
  end

  # hay una manera mas optima de colocar todas las rutas de productos seria esta
  # resources :products # de esta forma quedarai todas las urls de productos
  # implemetacion de vistas de perfiles
  resources :favorites, only: [ :index, :create, :destroy ], param: :product_id
  resources :users, only: [ :show ], path: "/user", param: :username # cambiamos el valor de id a username
  # si uno quiere que alguna vista sea la principal de home seria de la siguiente forma
  resources :categories, except: :show # quitamos la vista show
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

  # vista principal de ruta
  root to: "products#index", defaults: { format: :html }
end
