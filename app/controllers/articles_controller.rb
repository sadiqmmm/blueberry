class ArticlesController < ApplicationController
	before_action :set_article, only: [:edit, :update, :destroy]

	def index
		@articles = Article.order(title: :desc)
	end

	def show
		
		begin	  	
	  	@article = Article.find(params[:id])

	  	rescue ActiveRecord::RecordNotFound
	  		flash[:notice] = "No Article found with the Id #{params[:id]}"
	      redirect_to articles_path
	  	end		
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		if @article.save
			flash[:notice] = "Created - #{@article.title} !"
			redirect_to @article
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @article.update(article_params)
			flash[:notice] = "Updated - #{@article.title}"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def destroy
		if @article.destroy
		  redirect_to articles_path
		else
			redirect_to articles_path
		end
	end

	private

	  def article_params
	  	params.require(:article).permit(:title, :body, :image)
	  end

	  def set_article
	  	@article = Article.find(params[:id])
	  end
end
