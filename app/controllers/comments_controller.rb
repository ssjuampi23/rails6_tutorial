class CommentsController < ApplicationController
  def index
  end

  def show
    load_article
    load_comment
  end

  def new
    load_article
    @comment = @article.comments.new
  end

  def edit
    load_article
    load_comment
  end

  def create
    load_article
    @comment = @article.comments.new(comment_params)

    if @comment.save
      redirect_to article_comment_path(@article, @comment)
    else
      render 'new'
    end
  end

  def update
    load_article
    load_comment

    if @comment.update(comment_params)
      redirect_to article_comment_path(@article, @comment)
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def load_article
    @article = Article.find(params[:article_id])
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end
end
