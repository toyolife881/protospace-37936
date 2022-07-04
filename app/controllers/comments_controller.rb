class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      # redirect_to prototype_path(@comment.prototype_id)
      redirect_to prototype_path(@comment)
    else
      @prototype = @comment.prototypes
      @comment = Comment.new
      render "prototypes/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(prototype_id: params[:prototype_id], user_id:current_user.id)
  end
end
