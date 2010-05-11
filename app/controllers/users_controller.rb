class UsersController < ApplicationController

  before_filter :admin_required, :only => [:index, :show, :delete, :force_activation]

  def index
    @users = User.paginate(:page => (params[:page] || 1),
      :order => :login)#, :conditions => 'admin = 0')
  end

  def show
    @user = User.find(params[:id])

    @user_solutions_full = UserSolution.find_all_by_user_id(@user.id,
      :order => 'test_id ASC', :include => :test)

    @user_solutions = Test.find(:all).map do |test|
      {:test => test, :solution =>
          @user.find_recent_solution_to_test(test.id) || nil}
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    flash[:notice] = 'El usuario fue eliminado correctamente.'
    redirect_to users_url
  end

  def delete_all
    User.destroy_all 'admin = 0 or admin is null'

    flash[:notice] = 'Los usuarios han sido eliminados correctamente.'
    redirect_to(users_url)
  end

  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!

    @user = User.new(params[:user])

    # Si el DNI del usuario no se encuentra en el listado no intentamos registrarlo
    if Dni.find_by_value(@user.login)
      success = @user && @user.save
      if success && @user.errors.empty?
        redirect_back_or_default('/')
        flash[:notice] = "Gracias por registrarte! Te hemos enviado un correo con tu c&oacute;digo de activaci&oacute;n."
      else
        flash.now[:error]  = "No ha sido posible registrar tu cuenta. Por favor, int&eacute;ntalo de nuevo."
        render :action => 'new'
      end
    else
      flash.now[:error]  = "No puedes registrarte con el DNI que has indicado."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Registro completado! Por favor, haz login para continuar."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "C&oacute;digo de activaci&oacute;on vac&iacute;o.  Por favor, revisa la URL que enviamos a tu mail."
      redirect_back_or_default('/')
    else
      flash[:error]  = "No es posible encontrar un usuario con el c&oacute;digo de activaci&oacute;n que has indicado -- has revisado tu email? O quiz&aacute; tu cuenta ya haya sido activada -- intenta loguearte."
      redirect_back_or_default('/')
    end
  end

  def force_activation
    @user = User.find(params[:id])

    @user.activated_at = Time.now.utc
    @user.activation_code = nil
    @user.save(false)

    flash[:notice] = 'El usuario fue activado correctamente.'
    redirect_to users_url
  end
end
