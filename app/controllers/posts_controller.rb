class PostsController < ApplicationController
  def new
    @post = Post.new
    @categories = Category.order(:id)
  end

  def create
    @post = Post.new(post_params)
    @post.user = User.first! # TODO: Devise導入後に current_user に変更

    if @post.save
      redirect_to "/top"
    else
      @categories = Category.order(:id)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:category_id, :location, :body)
  end
end
