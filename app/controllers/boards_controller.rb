class BoardsController < ApplicationController
  before_action :authenticate_user!, only: :new
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new(flash[:board])
  end

  def create
    board = current_user.boards.new(board_params)
    if board.save
      flash[:notice] = "投稿が完了しました。"
      redirect_to boards_path
    else
      redirect_to new_board_path, flash: {
        board: board,
        error_messages: board.errors.full_messages
      }
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to boards_path
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    @board.update(board_params)
    if @board.save
      redirect_to board_path(@board.id)
    else
      flash[:error_messages] = @board.errors.full_messages
      flash[:board] = @board
      redirect_to edit_board_path
    end
  end

  private

    def board_params
      params.require(:board).permit(:content, :user_id)
    end
end

