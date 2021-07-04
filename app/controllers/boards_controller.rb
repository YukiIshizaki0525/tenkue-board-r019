class BoardsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
    @comments = Comment.includes(:user).where(board_id: @board.id)
    if user_signed_in?
      @comment = current_user.comments.new
    end
  end

  def new
    @board = current_user.boards.new
    @submit = "投稿する"
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


  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to boards_path
  end


  def edit
    @board = Board.find(params[:id])
    @submit = "更新する"
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

  private
    def board_params
      params.require(:board).permit(:content, :user_id)
    end

end
