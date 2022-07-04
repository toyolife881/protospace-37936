class PrototypesController < ApplicationController

  before_action :find_params, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:[:new, :edit, :destroy]

  def index
    if user_signed_in?
     @user = User.find(current_user.id)
    end

    @prototypes = Prototype.all.includes(:user)
  end

  def new
    @prototype = Prototype.new

  end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    # @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  
  end

  def edit
    # @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.user_id
      redirect_to root_path
    end
  end

  def update
    # @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    # @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end


  private

  def  find_params
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
  
end
