class CommentsController < ApplicationController

  def create

    @comment = Comment.new
    @comment.content = params[:content]
    @comment.user_id = current_user.id
    @comment.book_id = params[:book_id].to_i
    if @comment.save
      redirect_to :back
    end

    @book = Book.find(params[:book_id])
    @book_id = params[:book_id]
    @user = User.find(@book.user_id)
    @email = @user.email
    @comment = Comment.new
    @comment.content = params[:content]

    @comment.user_id = current_user.id

    @com_user = User.find(@comment.user_id)
    @comment.book_id = params[:book_id].to_i
      if @comment.save
        UserMailer.send_comment(@user, @book_id, @com_user.email).deliver
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
