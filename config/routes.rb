LcttPlatform::Application.routes.draw do
  root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update ]
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'

  resources :articles, :only => [:index, :show] do
    ### 创建文章
    get    :new,       to: 'articles#new',            on: :collection # 新建文章页面
    post   :suggest,   to: 'articles#suggest',        on: :collection # 新建推荐操作 [未创建->新推荐] new
    post   :create,    to: 'articles#create',         on: :collection # 新建原文操作 [未创建->新原文] new
    post   :approve,   to: 'articles#approve',        on: :member     # 批准推荐操作 [新推荐->新原文] show

    ### 翻译文章
    post   :claim,     to: 'articles#claim',          on: :member     # 认领原文操作 [新原文->翻译中] show
    get    :translate, to: 'articles#translate',      on: :member     # 翻译管理页面
    post   :submit,    to: 'articles#submit',         on: :member     # 提交翻译操作 [翻译中->已翻译] translate
    post   :cancel,    to: 'articles#cancel',         on: :member     # 放弃翻译操作 [翻译中->新原文] translate

    get :proofread, to: 'articles#proofread_index', on: :collection
    get :publish, to: 'articles#publish_index', on: :collection
    get :translate, on: :member
    get :proofread, on: :member
    get :publish, on: :member

    ### 管理文章
    post   :delete,    to: 'articles#destroy',        on: :member     # 归档文章操作 [+归档]
    post   :restore,   to: 'articles#destroy',        on: :member     # 恢复文章操作 [-归档]

    ### 内置操作
    # get    :index,   to: 'articles#index',          on: :collection # 文章列表页面
    # get    :how,     to: 'articles#how',            on: :member
  end

  get '/management' => 'management#index'
end
