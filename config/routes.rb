LcttPlatform::Application.routes.draw do
  root :to => "home#index"

  # 帐号管理
  resources :users, :only => [:index, :show, :edit, :update]

  # GitHub OAuth
  get '/auth/:provider/callback', to: 'sessions#create',  as: :auth_callback
  get '/signin',                  to: 'sessions#new',     as: :signin
  get '/signout',                 to: 'sessions#destroy', as: :signout
  get '/auth/failure',            to: 'sessions#failure', as: :auth_failure

  # 项目动态
  get '/activity', to: 'activity#index', as: :activity

  # 文章相关
  resources :articles, except: :destroy

  # 管理页面
  get '/management', to: 'management#index', as: :management
end
