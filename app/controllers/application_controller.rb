class ApplicationController < ActionController::Base
  helper OpenFresk::Engine.helpers
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = t('errors.not_authorized', default: 'Vous n’avez pas la permission d’accéder à cette page.')
    redirect_to(request.referrer || root_path)
  end
end
