class PostsController < ApplicationController
    def index  
       @posts = Post.all.order('created_at DESC').page params[:page] 
    end  
    
    def new
       @post = Post.new
    end
    
    def create
       @post = Post.create(post_params)
       if @post.save
          flash[:success] = "Your post has been created."
          redirect_to @post
       else
          flash[:alert] = "Missing Details! Please fill out the required details!"
          render :new
       end
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
          flash[:success] = "Post updated"
          redirect_to(post_path(@post)) 
       else
          flash[:alert] = "Something is wrong with your image"
          render :new
       end
    end
    
    def destroy  
      @post = Post.find(params[:id])
      @post.destroy
      flash[:success] = "Post deleted!"
      redirect_to posts_path
    end 
    
    private
    
    def post_params
       params.require(:post).permit(:customer_name, :customer_email, :customer_phone_no, :house_name, :house_address, :description, :post_type_select, :image)
    end
end
