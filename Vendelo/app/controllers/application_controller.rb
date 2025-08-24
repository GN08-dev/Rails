class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include Language
  # importacion de paginacion
  include Pagy::Backend
  include Error # manejo de excepciones de errores
end


# esto estaba antes de que pasara todo a unos archivos llamados concerns
###############################################################
# se paso al achivo en la carpeta concerns llamado authorization
# manejo de errores con una clase definida
# class NotAuthorizedError < StandardError
# end

# hacemos la accion que deseamos que realize cuando sea un error
# solo se ejecuta si hay un error en NotAuthorizedError
# rescue_from NotAuthorizedError do
#  redirect_to products_path, alert: t("common.not_authorized")
# end

##################################################################
# final de authorization parrafo 1
###################################################################

##################################################################
# parte 3 concerns de tipo lenguage el archivo
###################################################################
# obtener el lenguaje del navegador
# around_action :switch_locale
##################################################################
# parte 3 final de callback
###################################################################

#####################################################################
# parte 2 creado un archivo llamado authentication para el manejo de autenticacion
###########################################################################

# callback para el inicio de session
# before_action :Set_current_user # lo que hace es checar primero que usuario hace la peticon
# proteger rutas con un callback
# before_action :protect_pages

#############################################################################################
# fin de callbacks de sesion
############################################################################################

##################################################################
# parte 3 inicio de metodos del collback de obtener el lenguaje del navegador
###################################################################
# Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
# allow_browser versions: :modern
# def switch_locale(&action)
# I18n.with_locale(locale_from_header, &action)
# end
#
# private
# def locale_from_header
#  lang = request.env["HTTP_ACCEPT_LANGUAGE"]
#  code = lang.to_s.scan(/^[a-z]{2}/).first
#  code.presence || I18n.default_locale
# end


##################################################################
# parte 3 final
###################################################################


#############################################################################################
# parte 2 de metodos del callbakc de authentication
#############################################################################################
# metodo de busqueda
# def Set_current_user
# se usa find porque si no se encuentra el usuario manda un error y ya no deja la navegacion y para evitar eso y redirija alogin se usar find_by
# @current_user = User.find_by(session[:user_id]) forma uno
# se puede guardar la session exitosa por ya una variable accesible a todas las vistas
# o se crea mejor una clase que se encuentra oculta en rails que se llama current_attributes
# que es una clase que esta disponible en toda la aplicacion la cual que se podra usar en una clase, en las vistas o modelos
# forma dos con current en models
############################# antes de modificaciones este fue el de final_ ####################
# Current.user = User.find_by(id: session[:user_id]) if session[:user_id] # el if es validacion si exitste o no
# end

# def protect_pages
# redirijeme a  la vista login si no tenemos un current.user
# redirect_to new_session_path, alert: t("common.not_logged_in") unless Current.user
# end

#############################################################################################
# fin de parte 2 de metodos de authentication
#############################################################################################

#########################################################################
# se paso esta parte a un include en concerms llamado authozation
# def authorize! (record = nil) # este es el normal
# is_allow = if record
#    record.user_id == Current.user.id
# else
#  Current.user&.admin?
# end
# comparacion si es verdadero o falso el usuario que quiere acceder
# raise NotAuthorizedError unless is_allow

# solo realiza la redireccion si es falso para ello ocupamos el unless solo funciona en vistas y no en actualizaciones o errores
# redirect_to products_path, alert: t("common.not_authorized") unless is_allow
####################################################
# antes de pasarlo a include                      ##
# refacorizacion de codigo
# controller_name.singularize optiene el nombre del controlador y singular lo combierte a singular
# is_allow = "#{controller_name.singularize}Policy".classify.constantize.new(record).send(action_name)
# raise NotAuthorizedError unless is_allow
# end
