class CommentsController < ApplicationController

  def create
    comment = current_user.comments.new(comment_params)
    if comment.save
      flash[:notice] = "コメントを投稿しました"
      redirect_to comment.board
    else
      flash[:error_messages] = board.errors.full_messages
      render :new
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    if @comment.save
       redirect_to board_path(@comment.board.id), notice: "コメントを編集しました"
    else
      flash[:error_messages] = @comment.errors.full_messages
      flash[:board] = @comment
      redirect_to edit_board_comment_path(@comment.board.id,@comment.id)
    end
  end

  def edit
    if user_signed_in?
      @board = Board.find(params[:board_id])
      @comments = Comment.includes(:user).where(board_id: @board.id)
      @comment = Comment.find(params[:id])
    end
  end

  def destroy
    
      @comment = Comment.find_by(id: params[:id])
    if current_user.id == @comment.user_id
      @comment.destroy
      redirect_to board_path(@comment.board.id), flash: { notice: 'コメントを削除しました' }
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :board_id, :comment)
  end
end
