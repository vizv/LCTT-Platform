LcttPlatform::Application.routes.draw do
  root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update ]
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'

  resources :activity, :only => [:index, :show]

  resources :articles, :only => [:new, :create, :update, :destroy, :show] do
    get :suggest, to: 'articles#suggest', on: :collection
    get :translate, to: 'articles#translate_index', on: :collection
    delete :translate, to: 'articles#cancel_translate', on: :collection
    delete :translate, to: 'articles#cancel_translate', on: :member
    get :proofread, to: 'articles#proofread_index', on: :collection
    get :publish, to: 'articles#publish_index', on: :collection
    get :translate, on: :member
    get :proofread, on: :member
    get :publish, on: :member
  end

  get '/management' => 'management#index'
end
