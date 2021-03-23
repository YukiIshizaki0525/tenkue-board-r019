class HomesController < ApplicationController
  before_action :set_home, only: [:edit, :show]

  def index
    @homes = Home.all
  end

  def new
    @home = Home.new
  end

  def create
    Home.create(home_params)
  end

  def destroy
    home = Home.find(params[:id])
    home.destroy
  end

  def edit
  end

  def update
    home = Home.find(params[:id])
    home.update(home_params)
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
