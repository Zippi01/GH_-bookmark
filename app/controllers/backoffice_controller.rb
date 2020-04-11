class BackofficeController < ApplicationController
  before_action :check_admin
  layout "backoffice"

  def check_admin
    redirect_to "/bookmarks" unless current_user&.admin?
  end
end
