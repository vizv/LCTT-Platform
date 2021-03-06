class ArticlesController < ApplicationController
  respond_to :html

  def index
    authorize! :index, Article

    @articles = Article.all

    state = params[:state] and params[:state].to_sym
    @articles = @articles.where state: state if Article.valid_states.include? state
  end

  def new
    @article = Article.new params[:article]

    authorize! :new, @article
  end

  def create
    @article = Article.new params[:article]

    authorize! :create, @article

    @article.create! current_user rescue respond_with @article and return
    flash[:success] = "#{@article.state_label}「#{@article.title}」已创建。"

    respond_with @article
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

  def approve
    # TODO stub
  end

  def claim
    authorize! :claim, @article

    @article.claim! current_user
    flash[:success] = "「#{@article.title}」领取成功。"

    respond_with @article
  end

  def submit
    authorize! :submit, @article

    @article.submit! current_user, params[:article] and params[:article][:translation]
    flash[:success] = "「#{@article.title}」的译文已成功提交。"

    respond_with @article
  end

  def cancel
    authorize! :cancel, @article

    @article.cancel!
    flash[:success] = "你已放弃「#{@article.title}」的翻译。"

    respond_with @article
  end

  def accept
    authorize! :accept, @article

    @article.accept! current_user, params[:article] and params[:article][:publish]
    flash[:success] = "你已完成对「#{@article.title}」的校对。"

    respond_with @article
  end

  def deny
    authorize! :deny, @article

    @article.deny!
    flash[:success] = "你已否决「#{@article.title}」的翻译。"

    respond_with @article
  end

  def archive
    # TODO stub
  end

  def restore
    # TODO stub
  end
end
