class UsersController < ApplicationController
  def index
    users = User.all
    render json: users, include: [:posts]
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: { errors: user.errors }, status: 400
    end
  end

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user, include: [:posts]
    else
      render json: { error: "User with id #{params[:id]} does not exist" }, status: 404
    end
  end

  def update
    user = User.find_by(id: params[:id])
    if user
      if user.update(user_params)
        render json: user
      else
        render json: { errors: user.errors }, status: 400
      end
    else
      render json: { error: "User with id #{params[:id]} does not exist" }, status: 404
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      render json: user
    else
      render json: { error: 'delete operation not sucessfull' }, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
