class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # private filter method #set_user is called before the actions above run
  def new # implicitly renders app/views/users/new.html.erb - signup registration form
    @user = User.new # @user = instance for form_for to wrap around in signup form view
  end

  def show
    @message = params[:message] if params[:message]
    @message ||= false
  end

  def create # upon signup form submission, data is sent via POST request to "/users", mapped to users#create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id # log in the user
        format.html { redirect_to user_path(@user), notice: "You successfully registered! Welcome to the theme park, #{@user.name}!" }
      else
        flash.now[:error] = "Your registration attempt was unsuccessful. Please try again."
        format.html { render :new }
      end
    end
  end

  def edit # implicitly renders app/views/users/edit.html.erb (user edit form)
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: 'User was successfully updated.' }
      else
        flash.now[:error] = "Your attempt to edit user information was unsuccessful. Please try again."
        format.html { render :edit }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user # filter method called before every action, except #new and #create
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params # private method returns sanitized, strong params
      params.require(:user).permit(
        :name,
        :password,
        :height,
        :happiness,
        :nausea,
        :tickets,
        :admin
      )
    end
    # params must have top-level "user" key that points to (and stores) user hash nested inside of params hash
    # Within user hash (nested inside of params hash), we permit the following keys:
    # "name", "password", "height", "happiness", "nausea", "tickets" and "admin"
end

# When signup form is submitted to create a new user, params looks like this:
# params = {
#  "utf8"=>"✓",
#  "authenticity_token"=>"long string ==",
#  "user" => {
#    "name" => "Jenna",
#    "password" => "code",
#    "height" => "63",
#    "happiness" => "5",
#    "nausea" => "1",
#    "tickets" => "24",
#    "admin" => "1" (1 means user is an admin = true; 0 means user is NOT an admin = false)
#   },
#  "commit" => "Create User",
#  "controller" => "users",
#  "action" => "create"
# }
