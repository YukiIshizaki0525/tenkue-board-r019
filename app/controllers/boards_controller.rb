class BoardsController < ApplicationController
  before_action :authenticate_user!, only: :show

  def new
    @board = current_user.boards.new
  end

  def create
    board = current_user.boards.new(board_params)
    if board.save
      flash[:notice] = "投稿が完了しました。"
      redirect_to boards_path
    else
      flash[:error_messages] = board.errors.full_messages
      render :new
    end
  end

  private

    def board_params
      params.permit(:content, :user_id)
    end
end
