class ResourceTypesController < BaseController
  before_action :find_resource_type, except: [:index, :new, :create]

  def index
    @resource_types = ResourceType.all.page params[:page]
  end

  def show
  end

  def new
    @resource_type = ResourceType.new
  end

  def edit
  end

  def create
    @resource_type = ResourceType.new(params[:resource_type])
    if @resource_type.save
      flash[:notice] = 'ResourceType successfully created'
      redirect_to admin_resource_types_path
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def update
    if @resource_type.update_attributes(params[:resource_type])
      flash[:notice] = 'ResourceType was successfully updated'
      redirect_to admin_resource_types_path
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    if @resource_type.destroy
      flash[:notice] = 'ResourceType was successfully deleted'
      redirect_to admin_resource_types_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to admin_resource_types_path
    end
  end

  private

  def find_resource_type
    @resource_type = ResourceType.find(params[:id])
  end

end
