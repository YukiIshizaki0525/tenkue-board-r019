class BoardsController < ApplicationController
  before_action :authenticate_user!, only: :new
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = current_user.boards.new
  end

  def create
    board = current_user.boards.new(board_params)
    if board.save
      flash[:notice] = "投稿が完了しました。"
      redirect_to boards_path
    else
      flash[:error_messages] = @board.errors.full_messages
      render :new
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    board = Board.find(params[:id])
    board.update(board_params)
    if board.save
      redirect_to board
      # redirect_to board_path(board.id)
    else
      flash[:error_messages] = board.errors.full_messages
      redirect_to edit_board_path
    end
  end


  private

    def board_params
      params.require(:board).permit(:content, :user_id)
    end
end

