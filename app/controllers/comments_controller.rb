class CommentsController < ApplicationController
	load_and_authorize_resource 

	def create
		@comment = Comment.new(comment_params)
		
		article = Article.friendly.find(params[:article_id])

		@comment.article_id = article.id	   
		@comment.user_id = current_user.id
		@comment.author_name = current_user.name
		@comment.email = current_user.email
		@comment.save

		redirect_to article_path(@comment.article)
	end
	
	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end
