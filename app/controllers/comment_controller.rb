class CommentController < ApplicationController
  def create
    # @board = Board.find(params[:id])
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to comment.board
    else
      flash.now[:alert] = 'コメントを入力してください。'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, board_id: params[:id])
  end
end



#Createとdestroy　

#フォームを表示させるnewアクション

#詳細ページにコメントを出したい

#boads controllerにcommento

#newが使われてる時comment.new
