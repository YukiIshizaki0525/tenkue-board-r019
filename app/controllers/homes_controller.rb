class HomesController < ApplicationController
  before_action :set_home, only: [:edit, :show]

  def index
  end

  def edit
  end

  def show
  end

  private

  def home_params
    params.permit(:name, :text)
  end

  def set_tweet
    @home = Home.find(params[:id])
  end
end
