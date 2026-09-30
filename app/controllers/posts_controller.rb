class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_categories, only: [ :new, :create, :edit, :update ]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @posts = Post.published
  
    if params[:search].present?
      @posts = @posts.where("body LIKE ?", "%#{params[:search]}%")
    end
  
    if params[:category_id].present?
      @posts = @posts.where(category_id: params[:category_id])
    end
  
    @posts = @posts.order(created_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :asc).page(params[:page])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def drafts
    @posts = current_user.posts.draft.order(updated_at: :desc)
  end

  private

  def set_categories
    @categories = Category.order(:id)
  end

  def post_params
    params.require(:post).permit(
      :category_id,
      :body,
      :location,
      :image,
      :status
    )
  end

end
