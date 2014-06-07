class EateriesController < ApplicationController
  def new
    @eatery = @notebook.new_eatery
  end

  def create
    @eatery = @notebook.new_eatery(eatery_params)
    if @eatery.publish
      redirect_to root_path, notice: "Eatery added!"
    else
      render "new"
    end
  end
  
  
  private
  
  def eatery_params
    params.require(:eatery).permit(:name, :permalink)
  end
  
end
