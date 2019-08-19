class UsersController < ApplicationController
  def index
    if User.where(:name => params[:name]).any?
      @user = User.where(:name => params[:name]).first
      @campaigns = Campaign.where("user_id = ?", @user.id)
      @complaints = CampaignComplaint.where("user_id = ?",  @user.id)
      @donations = Donation.where(:user_id =>  @user.id).order(:created_at)
    else 
      redirect_to root_path
    end
  end

    def getting_started
      @user = User.find(current_user.id)
    end

    def profil_create
      @user = User.find(current_user.id)
      @user.update(started_params)
      redirect_to root_path(:id => current_user.id)
    end


    private
      def started_params
        devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
      end

end
