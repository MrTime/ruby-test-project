class CommentsController < ApplicationController

  def create
    @comment = Comment.new
    @comment.content = params[:content]
    @comment.user_id = current_user
    @comment.book_id = params[:book_id].to_i
    if @comment.save
      respond_to do |format|
        format.js {render :js => "jQuery('.comments tr:first').before('<tr><td class=\"span badge\">#{current_user.email}</td><td class=\"span badge badge-inverse\">#{@comment.created_at}</td></tr><tr class=\"well\"><td>#{@comment.content}</td><td><button>Delete</button></td></tr>');jQuery('#content').val('');"}
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
      format.js{ render :js => "jQuery('.comments .invisible').each(function(){
            if(this.innerHTML == #{@comment.id}){jQuery(this).parent().next().hide('slow');jQuery(this).parent().hide('slow');}
          });"}
      format.json { head :no_content }
    end
  end
end
