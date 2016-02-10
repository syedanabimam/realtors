class PostsController < ApplicationController
    def index  
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
    
    private
    
    def post_params
       params.require(:post).permit(:customer_name, :customer_email, :customer_phone_no, :house_name, :house_address, :description, :post_type_select, :image)
    end
end
