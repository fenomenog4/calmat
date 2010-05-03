class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Por favor, activa tu cuenta'
  
    @body[:url]  = "http://mseii.ugr.es/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Tu cuenta ha sido activada!'
    @body[:url]  = "http://mseii.ugr.es/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "iestructuras@ugr.es"
      @subject     = "[MSI2] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
