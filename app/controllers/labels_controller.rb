class LabelsController < ApplicationController
  
  def index
    @labels = current_user.labels
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    @label.user_id = current_user.id
    if @label.save
      flash[:primary] = 'ラベルを登録しました'
      redirect_to labels_path
    else
      render :new
    end
  end


  def edit
    @label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])
    if @label.update(label_params)
      flash[:success] = 'ラベルを更新しました'
      redirect_to labels_path
    else
      render :edit
    end
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    flash[:danger] = 'ラベルを削除しました'
    redirect_to labels_path
  end

  private
  
  def label_params
    params.require(:label).permit(:name)
  end
end