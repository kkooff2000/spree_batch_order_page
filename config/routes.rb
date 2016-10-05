Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  post 'home/add_to_cart' => 'home#add_to_cart'
end
