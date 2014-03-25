
class ResourcesController < BaseController

  before_action :find_resource, except: [:index, :new, :create]

  add_breadcrumb 'Dashboard', :admin_root_path
  add_breadcrumb 'Eventos', :admin_events_path
  add_breadcrumb 'Recursos', :admin_resources_path
  def index
    @resources = Resource.all.page params[:page]
  end

  def show
  end

  def new
    add_breadcrumb 'Nuevo Recurso', :new_admin_resource_path
    @resource = Resource.new
  end

  def edit
    add_breadcrumb 'Editar Recurso', nil
  end

  def create
    @resource = Resource.new(params[:resource])
    if @resource.save
      flash[:notice] = 'El recurso fue creado correctamente'
      redirect_to admin_resources_path
    else
      flash[:error] = 'Ups! Ocurrio un error'
      render 'new'
    end
  end

  def update
    if @resource.update_attributes(params[:resource])
      flash[:notice] = 'El recurso fue actualizado correctamente'
      redirect_to admin_resources_path
    else
      flash[:error] = 'Ups! Ocurrio un error'
      render 'edit'
    end
  end

  def destroy
    if @resource.destroy
      flash[:notice] = 'El recurso fue eliminado correctamente'
      redirect_to admin_resources_path
    else
      flash[:error] = 'Ups! Ocurrio un error'
      redirect_to admin_resources_path
    end
  end

  private

  def find_resource
    @resource = Resource.find(params[:id])
  end

end
