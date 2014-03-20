class Admin::ResourcesController < Admin::BaseController
  before_action :find_resource, except: [:index, :new, :create]

  def index
    @resources = Resource.all.page params[:page]
  end

  def show
  end

  def new
    @resource = Resource.new
  end

  def edit
  end

  def create
    @resource = Resource.new(params[:resource])
    if @resource.save
      flash[:success] = "El recurso fue creado correctamente"
      redirect_to @resource
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    if @resource.update_attributes(params[:resource])
      flash[:success] = "El recurso fue actualizado correctamente"
      redirect_to @resource
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    if @resource.destroy
      flash[:success] = "El recurso fue eliminado correctamente"
      redirect_to admin_resources_path
    else
      flash[:error] = "Something went wrong"
      redirect_to admin_resources_path
    end
  end

  private

    def find_resource
      @resource = Resource.find(params[:id])
    end

end
