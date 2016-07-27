class ArticlesController < ApplicationController
  respond_to :html

  def index
    authorize! :index, Article

    @articles = Article.all

    respond_with @articles
  end

  def new
    @article = Article.new params[:article]

    authorize! :new, @articles

    respond_with @article
  end

  def create
    @article = Article.new params[:article]

    authorize! :create, @article

    @article.user = current_user
    if @article.save
      flash[:success] = "#{@article.state_label}已创建。"
    end

    respond_with @article
  end

  def edit
    @article = Article.find params[:id]

    authorize! :edit, @article

    respond_with @articles
  end

  def show
    # 同时包括归档的文章
    @article = Article.find params[:id] rescue Article.deleted.find params[:id]

    authorize! :show, @article

    respond_with @articles
  end

  def update
    # 检查 action 然后调用
    binding.pry
    action = request.query_parameters[:action]
    actions = %(approve, claim, submit, cancel, accept, deny, archive, restore)
    render status: :not_found and return unless actions.include? action

    @article = Article.find params[:id] rescue Article.deleted.find params[:id]
    send action
  end

  private

  def claim
    authorize! :claim, @article

    if @articles.claim current_user
      flash[:success] = "#{@article} 领取成功。"
    else
      flash[:warning] = "#{@article} 被他人领取。"
    end

    respond_with @article
  end

  # FIXME: remove
  #############################

  ### 翻译管理页面
  def translate
    authorize! :translate, Article
    return not_exist unless @article = Article.by_id(params[:id])

    # 如果(当前译者 没有在翻译)并且(当前文章 是 新原文)那么(当前译者 认领新文章)
    if current_user.current_translating == nil and @article.is_new?
      @article.begin_translate current_user
    end

    authorize! :translate, @article
    respond_with @article
  end

  ### 提交翻译操作
  def finish_translate
    authorize! :finish_translate, Article

    # 如果(没有 指定 文章ID)那么(自动获取)
    if params[:id]
      return not_exist unless article = Article.by_id(params[:id])
    else
      return not_exist unless article = current_user.current_translating
    end

    authorize! :finish_translate, article

    # (提交翻译)并(重定向至 翻译进度页面)
    article.finish_translate
    redirect_to article_path(article)
  end

  ### 取消翻译操作
  def cancel_translate
    authorize! :cancel_translate, Article

    # 如果(没有 指定 文章ID)那么(自动获取)
    if params[:id]
      return not_exist unless article = Article.by_id(params[:id])
    else
      return not_exist unless article = current_user.current_translating
    end

    authorize! :cancel_translate, article

    # (取消翻译)并(重定向至 翻译认领页面)
    article.cancel_translate
    redirect_to translate_articles_path 
  end

  ### 翻译认领页面
  def translate_index
    authorize! :translate, Article

    # 如果(当前译者 正在翻译)那么(重定向至 翻译管理页面)
    if article = current_user.current_translating
      return redirect_to translate_article_path(article)
    end

    # 列出翻译相关文章
    @articles = Article.in(state: [:new, :translating, :translated])

    respond_with @articles
  end
end
