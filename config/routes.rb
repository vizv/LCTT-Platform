LcttPlatform::Application.routes.draw do
  root :to => "home#index"


  #### 帐号 ####

  # 帐号管理
  resources :users, :only => [:index, :show, :edit, :update]

  # GitHub OAuth
  get '/auth/:provider/callback', to: 'sessions#create',  as: :auth_callback
  get '/signin',                  to: 'sessions#new',     as: :signin
  get '/signout',                 to: 'sessions#destroy', as: :signout
  get '/auth/failure',            to: 'sessions#failure', as: :auth_failure


  #### 页面 ####
  # 项目动态
  get '/activity',          to: 'activity#index',   as: :activity
  # 文章列表
  get '/articles',          to: 'articles#index',   as: :articles
  # 新建推荐
  get '/articles/suggest',  to: 'articles#suggest', as: :suggest_article
  # 新建原文
  get '/articles/new',      to: 'articles#new',     as: :new_article
  # 编辑文章
  get '/articles/:id/edit', to: 'articles#edit',    as: :edit_article
  # 预览文章
  get '/articles/:id',      to: 'articles#show',    as: :show_article


  #### 操作 ####
  # 新建文章
  post '/articles/create',      to: 'articles#create',  as: :create_article
  # 批准推荐
  post '/articles/:id/approve', to: 'articles#approve', as: :approve_article
  # 认领原文
  post '/articles/:id/claim',   to: 'articles#claim',   as: :claim_article
  # 提交翻译
  post '/articles/:id/submit',  to: 'articles#submit',  as: :submit_article
  # 放弃翻译
  post '/articles/:id/cancel',  to: 'articles#cancel',  as: :cancel_article
  # 完成校对
  post '/articles/:id/accept',  to: 'articles#accept',  as: :accept_article
  # 否决翻译
  post '/articles/:id/deny',    to: 'articles#deny',    as: :deny_article
  # 归档文章
  post '/articles/:id/archive', to: 'articles#archive', as: :archive_article
  # 恢复文章
  post '/articles/:id/restore', to: 'articles#restore', as: :restore_article


  #### 管理页面 ####
  get '/management', to: 'management#index', as: :management
end
