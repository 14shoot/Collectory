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

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:category_id, :location, :body, :image)
  end
end
