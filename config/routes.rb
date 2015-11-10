Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post 'debfiles/upload/:token' => 'debfiles#upload'
    end
  end

  devise_for :users
  resources :debfiles do
    post 'upload', action: :upload
  end

  resources :projects do
    member do
      get 'build', action: :build
    end
  end
  
  resources :branches do
    collection do
      post :add_packages
    end

    member do
      get 'auto_add/:package_id', action: :auto_add, as: :auto_add_package
    end
  end
  
  resources :packages
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'projects#index'

  get 'library' => 'library#index', as: :library
  get 'library/rescan' => 'library#rescan', as: :rescan_library


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
