class ArticlesController < ApplicationController
  respond_to :html, :json

  def new
    @article = Article.new
    respond_with(@article)
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      flash[:success] = '新文章已创建。'
    end
    respond_with(@article)
  end
end
