class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user
  # private filter method #current_user will be called before every controller action is run
  # b/c ApplicationController is an inheritance point
  before_action :login_required, except: [:new, :create, :home]

  def logged_in?
    !!current_user # the truthiness of calling #current_user
  end

  private

    def login_required # redirect to homepage (static_pages#home) unless user is logged in
      redirect_to root_path unless logged_in?
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    helper_method :current_user # makes #current_user available to view files
end
# If a user is logged in, session[:user_id] is present, which = the user's id attribute value
# If a user is logged in, the first time #current_user is called, @current_user is set = to the
# user instance whose id attribute value = session[:user_id]
# On subsequent calls of #current_user, we just return @current_user (the same user instance),
# so we're not hitting the DB every time
