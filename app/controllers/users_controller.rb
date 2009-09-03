class UsersController < ApplicationController
  before_filter :login_required, :only => [:index, :password, :update_password]
  skip_before_filter :check_site_status, :except => [ :index ]

  def index
    @users = User.find :all
  end

  def new
    login_required unless User.count == 0
    @user = User.new
  end
 
  def create
    login_required unless User.count == 0
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      unless logged_in?
        self.current_user = @user # now logged in as this user
      end
      flash[:notice] = "New user created."
      redirect_to users_path
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again."
      render :action => 'new'
    end
  end

  def password
		@user = User.find(params[:id])
	end

	def update_password
		@user = User.find(params[:id])
  	if @user.update_attributes(params[:user])
			flash[:notice] = "New password for <em>#{@user.login}</em> has been saved."
			redirect_to users_path
		else
			render :action => 'password'
    end
	end
end
