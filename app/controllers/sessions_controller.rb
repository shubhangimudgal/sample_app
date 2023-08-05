class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(session_params[:email])
    if user && user.authenticate(session_params[:password])
      reset_session
      session_params[:remember_me] == '1' ? remember(user) : forget(user)
      log_in user
      redirect_to user
       # Log the user in and redirect to the user's show page.
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :remember_me)
  end
end



