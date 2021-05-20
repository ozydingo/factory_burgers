class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: user.to_json
  end
end
