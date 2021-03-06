class ApplicationController < ActionController::Base
  
    def after_sign_in_path_for(resource)
      user_path(resource.id)
      # ログイン後に遷移するpathを設定
    end
  
    def after_sign_out_path_for(resource)
      root_path
      # ログアウト後に遷移するpathを設定
    end


    before_action :configure_permitted_parameters, if: :devise_controller?
    protected
    def configure_permitted_parameters
      added_attrs = [ :email, :name, :password, :password_confirmation ]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    end

end
