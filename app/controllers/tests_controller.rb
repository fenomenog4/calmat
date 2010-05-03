require 'fileutils'

class TestsController < ApplicationController
  before_filter :login_required
  before_filter :admin_required, :except => [:index, :download, :show, :solve]

  def index
    @tests = Test.paginate(:page => (params[:page] || 1))
  end

  def show
    @test = Test.find(params[:id])
    @user_solution = UserSolution.new

    if (recent_user_solution = current_user.find_recent_solution_to_test(@test.id)) &&
        recent_user_solution.right?
      flash[:error] = 'Ya has resuelto correctamente esa pr&aacute;ctica, no puedes volver a intentarlo'
      redirect_to tests_path
    end
  end

  def solve
    @test = Test.find(params[:id])
    @user_solution = UserSolution.new(:user_id => current_user.id,
      :test_id => @test.id,
        :value => params[:user_solution][:value])

    if (recent_user_solution = current_user.find_recent_solution_to_test(@test.id)) &&
        recent_user_solution.right?
      flash[:error] = 'Ya has resuelto correctamente esa pr&aacute;ctica, no puedes volver a intentarlo'
      redirect_to tests_path
    end

    if @user_solution.save
      # Buscamos el resultado de calmat a la práctica para compararla
      calmat_solution = CalmatSolution.find_by_test_id_and_user_id(@test.id, current_user.id)
	
      if not calmat_solution.nil?
        if calmat_solution.value
          #if calmat_solution.value == @user_solution.value
          if calmat_solution.equivalent?(@user_solution)
            flash[:success] = 'El resultado introducido es correcto'
            @user_solution.right = true
          else
            flash[:error] = 'El resultado introducido no es correcto'
            @user_solution.right = false
          end
        else
          flash[:error] = 'El resultado introducido no es correcto'
          @user_solution.right = false
        end
      else
         flash[:error] = 'Bajate el enunciado antes de meter los resultados'
      end

      @user_solution.save

      redirect_to(tests_path)
    else
      render :action => 'show'
    end
  end

  # En esta acción genero los ficheros de datos y de latex para el usuario,
  # a partir de ellos creo el CalmatSolution con la solución a la práctica y
  # el pdf con el enunciado. Por último el pdf generado es enviado al usuario.
  def download
    test = Test.find(params[:id])

    # Creación del directorio de trabajo para el usuario
    FileUtils.mkdir_p "#{test.data_dir}/#{current_user.dni}"

    # Generación de las plantillas para el ususario
    latex_filepath = test.data_dir + "/#{current_user.dni}/" +
      test.latex_filename_for(current_user)
    File.open(latex_filepath, 'w+') do |f|
      f.write(test.latex_template(current_user))
    end

    data_filepath = test.data_dir + "/#{current_user.dni}/" +
      test.data_filename_for(current_user)
    File.open(data_filepath, 'w+') do |f|
      f.write(test.data_template(current_user))
    end

    # Invocación al ejecutable de calmat si es que no existe una solución previa
       # data_filepath es el path del archivo datos del alumno que se genera a partir del generico (que es ej.dat.erb) cuando se han sustitudo los datos del alumno
       # test.data_dir es el directorio donde guardamos los erb de ese test y las imágenes
    unless CalmatSolution.find_by_test_id_and_user_id(params[:id], current_user.id)
      system("cd #{test.data_dir}/#{current_user.dni}; echo \"#{test.data_filename_for(current_user)}\" | #{RAILS_ROOT}/app/calmat > fichero.rsl")
      calmat_solution = CalmatSolution.new(:test_id => test.id, :user_id => current_user.id)
      File.open(test.data_dir + "/#{current_user.dni}/fichero.rsl", 'r') do |f|
        calmat_solution.value = f.readlines.map(&:strip).join(', ')
      end
      calmat_solution.save
    end

    # Generación del pdf
    system("cd #{test.data_dir}/#{current_user.dni}; texi2dvi #{test.latex_filename_for(current_user)}")
    system("cd #{test.data_dir}/#{current_user.dni}; dvipdf #{test.dvi_filename_for(current_user)}")

    pdf_filepath = test.data_dir + "/#{current_user.dni}//" +
      test.pdf_filename_for(current_user)
    send_data(File.read(pdf_filepath), :filename => "p#{params[:id]}.pdf",
      :type => "application/pdf", :disposition => "attachment")
  end

  def new
    @test = Test.new
  end

  def edit
    @test = Test.find(params[:id])
  end

  def create
    @test = Test.new(params[:test])

    if @test.save
      flash[:success] = 'La pr&aacute;ctica ha sido creada correctamente.'
      redirect_to(tests_url)
    else
      render :action => "new"
    end
  end

  def update
    @test = Test.find(params[:id])

    if @test.update_attributes(params[:test])
      flash[:success] = 'La pr&aacute;ctica ha sido actualizada correctamente.'
      redirect_to(tests_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @test = Test.find(params[:id])
    @test.destroy

    redirect_to(tests_url)
  end

  def new_image_file
    render :partial => 'new_image_file'
  end

end
