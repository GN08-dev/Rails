module Authentication
  extend ActiveSupport::Concern
  included do
    before_action :Set_current_user
    before_action :protect_pages

    private
    def Set_current_user
      Current.user = User.find_by(id: session[:user_id]) if session[:user_id] # el if es validacion si exitste o no
    end
    def protect_pages
      # redirijeme a  la vista login si no tenemos un current.user
      redirect_to new_session_path, alert: t("common.not_logged_in") unless Current.user
    end
  end
end
