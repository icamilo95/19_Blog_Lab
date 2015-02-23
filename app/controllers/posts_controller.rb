class PostsController < ApplicationController
  def index
      @author = Author.find params[:author_id]
      @posts = @author.posts
      
  end

  def new

      @author = Author.find params[:author_id]
      @posts = Post.new
  end

  def create
      @author = Author.find params[:author_id]
      @posts = Post.new post_params
      @posts.author = @author
      if @posts.save
         # author_posts_path  ??
         redirect_to :action => :index
      else
          render :new
      end 
  end

  def show
      @post = Post.find params[:id]
      @author = @post.author
  end

  def edit
      @post = Post.find params[:id]
      @author = @post.author

  end

  def update
     @post = Post.find params[:id]
     @author = @post.author
     @post.update_attributes post_params
      if @post.save
         redirect_to :action => :show
      else
          render :edit
      end 
  end

  def destroy
      post = Post.find params[:id]
      post.destroy
      author = post.author
      redirect_to author_posts_path(author)
  end


  def post_params
   params.require(:post).permit(:title, :body, :category, :author_id)
  end

end
