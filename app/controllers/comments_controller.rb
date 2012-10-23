class CommentsController < ApplicationController

  def create
    @comment = Comment.new
    @comment.content = params[:content]
    @comment.user_id = current_user.id
    @comment.book_id = params[:book_id].to_i
    if @comment.save
      redirect_to :back
    end
  end


  #def destroy
  #  @comment = Comment.find(params[:id])
  #  @comment.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to comments_url }
  #    format.json { head :no_content }
  #  end
  #end
end
