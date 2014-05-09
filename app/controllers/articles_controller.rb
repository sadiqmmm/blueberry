class ArticlesController < ApplicationController
    
	before_action :set_article, only: [:edit, :update, :destroy]
	before_action :authenticate_user_with_msg, except: [:index]
    
    load_and_authorize_resource :find_by => :slug

	def index
		@articles = Article.order(updated_at: :desc).page(params[:page]).per(2)		
		authorize! :index, @article
	end

	def show
		
		begin	  	
	  
	  	authorize! :read, @article

	  	rescue ActiveRecord::RecordNotFound
	  		flash[:notice] = "No Article found '#{params[:id]}'"
	      redirect_to articles_path
	  	end		
	end

	def new
		@article = Article.new
	    authorize! :new, @article	
	end

	def create
		@article = Article.new(article_params)
		authorize! :create, @article

		@article.user_id = current_user.id
		if @article.save
			flash[:notice] = "Created - #{@article.title} !"
			redirect_to @article
		else
			render 'new'
		end
	end

	def edit
		 authorize! :edit, @article
	end

	def update
		if @article.update(article_params)
		authorize! :update, @article
			flash[:notice] = "Updated - #{@article.title}"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def destroy
	 
    	authorize! :destroy, @article.destroy
		redirect_to articles_path				
	end

	private

	  def article_params
	  	params.require(:article).permit(:title, :body, :image)
	  end

	  def set_article
	  	@article = Article.friendly.find(params[:id])

	  end

	  def authenticate_user_with_msg
		if signed_in?			
			
		else
			flash[:notice] = "Please Login"
		end
		authenticate_user!
	end

end
