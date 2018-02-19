class SessionsController < ApplicationController
  def new # implicitly renders app/views/sessions/new.html.erb (login form)
    @user = User.new # @user is instance for form_for to wrap around
    @users = User.all # @users stores 'array' of all user instances
    # b/c we need all user names for dropdown menu in user login form
  end
  # sign-in form data is submitted via POST request to "/sessions/create", mapped to sessions#create
  def create # receives data submitted in login form, authenticates and logs in a valid user
    @user = User.find_by(name: params[:user][:name])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id # log in the user
      redirect_to user_path(@user), notice: "You successfully logged in. Welcome back to the theme park, #{@user.name}!"
    else # present sign-in form so user can try logging in again
      redirect_to signin_path, notice: "Your login attempt was unsuccessful. Please enter a valid username and password combination."
    end
  end

  def destroy # logging out the user
    reset_session # To log out the user, you can also say session[:user_id] = nil or session.clear
    redirect_to root_url, notice: "Thanks for visiting the theme park. Goodbye for now!"
  end
end

# When sign-in form data is submitted, params has a top-level "user" key,
# which points to (and stores) user hash nested inside of params hash
# Within the user hash (nested inside of params hash), we have "name" and "password" keys,
# which each points to whatever was submitted in corresponding form field
