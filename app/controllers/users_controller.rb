class UsersController < ApplicationController
  def show
    @users = User.find(params[:id])
    @prototypes = @users.prototypes
  end

  # private
  # def comment_params
  #   params.require(:user).permit(:user_id).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  # end
 end
