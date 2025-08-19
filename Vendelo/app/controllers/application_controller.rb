class ApplicationController < ActionController::Base
  #importacion de paginacion 
  include Pagy::Backend
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  #obtener el lenguaje del navegador 
  around_action :switch_locale

  def switch_locale(&action)
   I18n.with_locale(locale_from_header, &action)
  end

  private 
  def locale_from_header
    lang = request.env["HTTP_ACCEPT_LANGUAGE"]
    code = lang.to_s.scan(/^[a-z]{2}/).first
    code.presence || I18n.default_locale
  end


end
