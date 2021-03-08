class BoardsController < ApplicationController

  def new
    if user_signed_in?
      @board = Board.new(flash[:board])
    else
      redirect_to root_path, flash: {
        alert: "ログインまたは新規登録が必要です。"
      }
    end
  end

  def create
    board = Board.new(board_params)
    if board.save
      flash[:notice] = "「#{board.title}」の掲示板を作成しました"
      redirect_to board
    else
      redirect_to new_board_path, flash: {
        board: board,
        error_messages: board.errors.full_messages
      }
    end
  end

  private

    def board_params
      params.require(:board).permit(:content)
    end
end
