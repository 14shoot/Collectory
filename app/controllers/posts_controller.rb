class PostsController < ApplicationController
  def new
    @post = Post.new
    @categories = Category.order(:id)
  end

  def create
    @post = Post.new(post_params)
    @post.user = User.first!
  
    if @post.save
      redirect_to "/top"
    else
      puts @post.errors.full_messages
      @categories = Category.order(:id)
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @posts = Post.all
  end

  private

  def post_params
    params.require(:post).permit(:category_id, :location, :body)
  end
end
