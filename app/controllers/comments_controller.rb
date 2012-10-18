class CommentsController < ApplicationController

  def create
    @comment = Comment.new
    @comment.content = params[:content]
    @comment.user_id = current_user.id
    @comment.book_id = params[:book_id].to_i
    if @comment.save
      respond_to do |format|
        format.js {render :js => "jQuery('.comments tr:first').before('<tr><td>#{current_user.email}</td><td>#{@comment.created_at}</td><td>#{@comment.content}</td><td><button>X</button></td></tr>');jQuery('#content').val('');"}
        format.html { redirect_to :back}
      end
    end
  end

  def index
    @comments = Comment.desc
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
