class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create # <ActionController::Parameters {"title"=>"www", "text"=>"12122"} permitted: false>
    # render plain: params[:article].inspect
    # @article = Article.new(params[:article]) WITHOUT Strong Params
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new' # the same @article object is passed back to the new.html.erb view with all the data
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
