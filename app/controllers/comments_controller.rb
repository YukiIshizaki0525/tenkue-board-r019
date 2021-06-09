class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to comment.board
    else
      flash[:error_messages] = comment.errors.full_messages
      redirect_back fallback_location: comment.board
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    redirect_to board_path(@comment.board.id), flash: { notice: 'コメントを削除しました' }
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :board_id, :comment)
  end
end
