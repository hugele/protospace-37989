class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  
  def new
    @prototype = Prototype.new
  end

 def index
    @prototypes = Prototype.includes(:user)
    # includes(:user).order("created_at DESC")
  end
  
  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments =  @prototype.comments.includes(:user)
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render action: :new
    end
  end
  
  def edit
    @prototype = Prototype.find(params[:id])
    # redirect_to root_path unless current_user.id == @prototype.user_id
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render action: :edit
    end
  end
 
  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end 
  
  def move_to_index
    prototype = Prototype.find(params[:id])
    if prototype.user_id != current_user.id
      rredirect_to new_user_session_path unless user_signed_in?
    end
  end
end
