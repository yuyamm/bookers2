class UsersController < ApplicationController

	def index
		@user = User.find(current_user.id)
		@book = Book.new
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@book = Book.new
	end

	def edit
		@user = User.find(params[:id])
		if current_user.id != @user.id
			redirect_to user_path(current_user.id)
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "You have updated successfully."
			redirect_to user_path(@user)
		else
			render :edit
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :profile_image, :introduction)
	end
end
