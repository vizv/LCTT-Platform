class ArticlesController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  def suggest
    # TODO: stub
  end

  def new
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
    @article = Article.where(id: params[:id]).first

    unless @article
      flash[:danger] = '文章不存在！'
    end
    respond_with @article
  end

  ###

  def create
    @article = Article.new(params[:article])
    if @article.save
      flash[:success] = '新文章已创建。'
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
