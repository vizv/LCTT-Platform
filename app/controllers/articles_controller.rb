class ArticlesController < ApplicationController
  respond_to :html, :json

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

  def translate
    # TODO: stub
  end

  def translate_index
    # TODO: stub
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
    unless @article = Article.where(id: params[:id]).first
      flash[:danger] = '该文章不存在！'
      return redirect_to root_path
    end

    authorize! :show, @article

    respond_with @article
  end

  ###

  def create
    state_action = params[:article] && params[:article][:state]
    authorize! state_action.to_sym, Article if ['suggest', 'new'].include? state_action

    @article = Article.new(params[:article])
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
end
