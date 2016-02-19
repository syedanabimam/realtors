class PostsController < ApplicationController
  # To authenticate current users & stop users to edit, update or delete each other posts
  before_action :authenticate_user! 
  before_action :owned_post, only: [:edit, :update, :destroy] 
  before_action :is_admin, only: [:reports]
    # Home page: queries all the posts and paginate them accorsingly
    def index  
      @posts = Post.all.order('created_at DESC').page params[:page] 
    end
    
    # Generate Reports
    def reports
      @type = params[:type]
      # Expects a type parameter which tells what kind of report needs to be generated
        case @type
        # Report generated that contains info of all posts
        when "All"    
          @posts_all = Post.all 
        # Report generated that contains info of posts that have not been rented 
        when "Not Rented"    
          @posts_all = Post.all.where("status = ?", params[:type]) unless params[:type].blank? 
        # Report generated that contains info of posts that have been rented
        when "Rented"    
           @posts_all = Post.all.where("status = ?", params[:type]) unless params[:type].blank?
        # Report generated that contains info of posts that have been sold
        when "Sold"
           @posts_all = Post.all.where("status = ?", params[:type]) unless params[:type].blank?
        # Report generated that contains info of posts that have not been sold
        when "Not Sold"
           @posts_all = Post.all.where("status = ?", params[:type]) unless params[:type].blank?
        else
          ##
        end  
      
      # This block of code passes the type of query and posts object to Prawne instance
      # variable, which in turn generates a report and returns a pdf format files
      vars = [@posts_all, @type]
      respond_to do |format|
        format.html
        format.pdf do 
          pdf = ReportPdf.new(vars)
          send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
        end
      end      
    end
    
    # Creates new instance of Post Object
    def new
       @post = current_user.posts.build #Post.new
    end
    
    # This action saves the new form values to database upon checking if the record
    # can be saved. A successful save returns a flash message while user is informed
    # in case record is unable to saved
    def create
       @post = current_user.posts.build(post_params) #Post.create(post_params)
       if @post.save
          flash[:success] = "Your post has been created."
          redirect_to @post
       else
          flash[:alert] = "Missing Details! Please fill out the required details!"
          render :new
       end
    end
    
    # This action manages the show form for each posts. 
    def show
       @post = Post.find(params[:id])
       # The hash below allows to use gmap4rails helper methods to customize
       # google map interface
       @hash = Gmaps4rails.build_markers(@post) do |post_add, marker|
        marker.lat post_add.latitude
        marker.lng post_add.longitude
        marker.infowindow post_add.house_name
      end
    end
    
    # This action controls the edit part of the application
    def edit
       @post = Post.find(params[:id])
       # Conditional below checks if the property is rented or sold
       # if it is, then it flashes out a message informing that a
       # sold or rented post can not be edited
       if @post.status == "Sold" || @post.status == "Rented"
         flash[:error] = "This property has already been #{@post.status} and therefore cannot be edited"
         redirect_to(post_path(@post))
       end
    end
    
    # This action manages the updating part of the app
    def update
       @post = Post.find(params[:id])
       # Conditional below checks if the post`s record that needs to be updated
       # can be saved
       if @post.update(post_params)
          flash[:success] = "Post updated"
          redirect_to(post_path(@post)) 
       else
          flash[:alert] = "Something is wrong with your image"
          render :new
       end
    end
    
    # Destroy action which comes with RESTFUL API resources deletes an active record 
    # from the database and flashes out a message confirming post has been deleted
    def destroy  
      @post = Post.find(params[:id])
      @post.destroy
      flash[:success] = "Post deleted!"
      redirect_to posts_path
    end 
    
    # This is a custom action, not part of the REST API and it deals with when user clicks
    # buy or rent buttons in index or show page
    def transaction
      @post = Post.find(params[:id])
      # Below it is sending the action name as a param to the post model, for model to act 
      # accordingly to update the database once transaction has been made
      @post.action_n(action_name)
      # This conditional checks if record belongs to a post with a certain status, after
      # confirming, it updates the record
      if @post.post_type_select == "Rent"
          @post.status = "Rented" 
          @post.save
           flash[:success] = "#{@post.house_name} Rented!" 
          redirect_to posts_path
      else
          @post.status = "Sold"
          @post.save
          flash[:success] = "#{@post.house_name} Sold!" 
          redirect_to posts_path 
      end 
    end
 
    private
    
    # This private method whitelist the Post object params for it to be use above for different
    # actions
    def post_params
       params.require(:post).permit(:customer_name, :customer_email, :customer_phone_no, :house_name, :house_address, :description, :post_type_select, :image, :status, :rent_price, :city, :country, :google_address)
    end
    
    # This method checks if the current user matches to the one whom the posts belong to
    def owned_post
      @post = Post.find(params[:id])
      unless current_user == @post.user
        flash[:alert] = "Only owner of the posts are allowed to edit them!"
        redirect_to root_path
      end
    end 
    
    def is_admin 
       unless current_user.admin == true
        flash[:alert] = "Only Admin is allowed to view reports!"
        redirect_to root_path
       end
    end

end
