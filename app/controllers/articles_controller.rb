class ArticlesController < ApplicationController
  respond_to :html

  def index
    authorize! :index, Article

    @articles = Article.all
  end

  def new
    @article = Article.new params[:article]

    authorize! :new, @article
  end

  def create
    @article = Article.new params[:article]

    authorize! :create, @article

    @article.user = current_user
    if @article.save
      flash[:success] = "#{@article.state_label}已创建。"
    end
  end

  def edit
    @article = Article.find params[:id]

    authorize! :edit, @article
  end

  def show
    # 同时包括归档的文章
    @article = Article.find params[:id] rescue Article.deleted.find params[:id]

    authorize! :show, @article
  end

  def update
    # 检查 action 然后调用
    action = request.query_parameters[:action]
    actions = %w(approve claim submit cancel accept deny archive restore)
    render status: :not_found and return unless actions.include? action

    @article = Article.find params[:id] rescue Article.deleted.find params[:id]
    send action
  end

  private

  def claim
    authorize! :claim, @article

    if @article.claim current_user
      flash[:success] = "#{@article} 领取成功。"
    else
      flash[:warning] = "#{@article} 被他人领取。"
    end
  end

  def submit
    authorize! :submit, @article

    if @article.submit current_user, params[:article] and params[:article][:translation]
      flash[:success] = "#{@article} 的译文已经成功提交。"
    else
      flash[:warning] = "#{@article} 已经提交。"
    end
  end

  def cancel
    # TODO stub
  end

  def accept
    # TODO stub
  end

  def deny
    # TODO stub
  end

  def archive
    # TODO stub
  end

  def restore
    # TODO stub
  end
end
