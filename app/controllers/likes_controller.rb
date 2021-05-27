class LikesController < ApplicationController
  before_action :board_params

  def create
    current_user.likes.create(board_id: @board.id)
  end

  def destroy
    current_user.likes.find_by(board_id: @board.id).destroy
  end

  private
    def board_params
      @board = Board.find(params[:board_id])
    end
end