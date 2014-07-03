class ArticlesController < ApplicationController
  respond_to :html

  def suggest
    authorize! :suggest, Article
    @article = Article.new
    respond_with @article
  end

  def new
    authorize! :new, @article
    @article = Article.new
    respond_with @article
  end

  ### 翻译页面
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

  ### 取消翻译操作
  def cancel_translate
    authorize! :cancel_translate, Article

    # 如果(没有 指定 文章ID)那么(自动获取)
    if params[:id]
      return not_exist unless article = Article.by_id(params[:id])
    else
      return not_exist unless article = current_user.current_translating
    end

    authorize! :translate, article

    # (取消翻译)并(返回 翻译认领页面)
    article.cancel_translate
    redirect_to translate_articles_path 
  end

  ### 翻译认领页面
  def translate_index
    authorize! :translate, Article

    # 如果(当前译者 正在翻译)那么(重定向至 翻译页面)
    if article = current_user.current_translating
      return redirect_to translate_article_path(article)
    end

    # 列出翻译相关文章
    @articles = Article.in(state: [:new, :translating, :translated])

    respond_with @articles
  end

  def proofread
    # TODO: stub
  end

  def proofread_index
    # TODO: stub
  end

  def publish
    # TODO: stub
  end

  def publish_index
    # TODO: stub
  end

  ###

  def show
    authorize! :show, Article
    return not_exist unless @article = Article.by_id(params[:id])
    authorize! :show, @article
    respond_with @article
  end

  ###

  def create
    # 检查用户是否可以(创建|建议)原文
    state_action = params[:article] && params[:article][:state]
    authorize! state_action.to_sym, Article if ['suggest', 'new'].include? state_action

    # 尝试创建
    @article = Article.new(params[:article])
    @article.user = current_user
    if @article.save
      flash[:success] = "新#{state_action == 'suggest' && '推荐' || '原文'}已创建。"
    end

    respond_with @article
  end

  def update
    # TODO: stub
  end

  def destroy
    # TODO: stub
  end

  private

  def not_exist
    flash[:danger] = '无法执行该操作：文章不存在！'
    redirect_to root_path
  end
end
