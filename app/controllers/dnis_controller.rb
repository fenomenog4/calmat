class DnisController < ApplicationController
  before_filter :admin_required
  
  def index
    @dnis = Dni.paginate(:page => (params[:page] || 1), :order => :value)
  end

  def new
    @dni = Dni.new
  end

  def load
    if request.post?
      if params[:file]
        dnis = params[:file].readlines

        dnis.each do |dni|
          Dni.create(:value => dni.strip!)
        end

        flash[:notice] = 'El fichero ha sido cargado correctamente.'
        redirect_to dnis_path
      else
        flash[:error] = 'Debes indicar un fichero para que la carga se lleve a cabo.'
        redirect_to load_dnis_path
      end
    end
  end

  def create
    @dni = Dni.new(params[:dni])

    if @dni.save
      flash[:notice] = 'El DNI ha sido creado correctamente.'
      redirect_to(dnis_url)
    else
      render :action => "new"
    end
  end

  def update
    @dni = Dni.find(params[:id])

    if @dni.update_attributes(params[:dni])
      flash[:notice] = 'El DNI fue actualizado correctamente.'
      redirect_to(dnis_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @dni = Dni.find(params[:id])
    @dni.destroy

    flash[:notice] = 'El DNI fue eliminado correctamente.'
    redirect_to(dnis_url)
  end

  def delete_all
    Dni.delete_all

    flash[:notice] = 'Los DNIs han sido eliminados correctamente.'
    redirect_to(dnis_url)
  end
end
