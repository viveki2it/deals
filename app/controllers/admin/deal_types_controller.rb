class Admin::DealTypesController < Admin::AdminController


  def index
    @deal_type = DealType.new
    @deal_types = DealType.find(:all)
  end

  def create
    @deal_type = DealType.new(params[:deal_type])
    if @deal_type.save
      flash[:notice] = 'Your deal type is successfully created'
      render :update do |page|
        page.redirect_to admin_deal_types_path
      end
    end
  end

  def edit
    @deal_type = DealType.find(params[:id])
  end

  def update
    @deal_type = DealType.find(params[:id])
    if @deal_type.update_attributes(params[:deal_type])
      render :update do |page|
        page << "$('#deal_type_name_#{params[:id]}').html('#{@deal_type.name}');$('#deal_type_name_edit_form_#{params[:id]}').hide();$('#deal_type_name_edit_#{params[:id]}').show();"
      end
    end
  end

  def destroy
    @deal_type = DealType.find(params[:id])
    render :update do |page|
      if @deal_type.destroy
        page << "$('#deal_type_#{params[:id]}').html('');"
        page.alert("successfully deleted")
      else
        page.alert("deletion failed")
      end
    end
  end
end
