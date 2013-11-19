class Admin::ImagesController < ApplicationController
  
  def create
    @deal = Deal.find(params[:deal_id])
    params[:image_images].to_a.each do |image_image|
      @deal.images.build(:image => image_image)
    end
    if @deal.save
      flash[:notice] = "Images has been uploaded successfully"
    else
      flash[:error] = 'Images upload failed. Please upload again'
    end
    redirect_to edit_admin_deal_path(@deal)
  end

  def destroy
    @image = Image.find(params[:id])
    render :update do |page|
      if  @image.destroy
        page << "$('#deal_image_#{params[:id]}').html('');"
        page.alert("successfully deleted")
      end
    end
  end
end
