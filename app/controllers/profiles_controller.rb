class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :policy]

  def index
    @search = Profile.search(params[:search])
    @profiles = @search.paginate(:page => params[:page], :per_page => 20)
    respond_to do |format|
      format.html
      format.json { render json: @profiles }
      format.js
    end
  end

  def new
    redirect_to new_user_registration_path
  end

  def show
    @profile = Profile.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @profile }
    end
  end

  # Shows the logged user profile
  def profile
    @profile = current_user.profile
    respond_to do |format|
      format.html
      format.json { render json: @profile }
    end
  end

  def edit_profile
    @profile = current_user.profile.nil? ? current_user.build_profile : current_user.profile
    respond_to do |format|
        if !params[:profile]
          format.html #edit_profile.html.erb
        elsif @profile.update_attributes(params[:profile])
          format.html { redirect_to profile_path(@profile), notice: 'Profile was successfully updated.' }
          format.json { head :ok }
        else
          format.html #edit_profile.html.erb
          format.json { render json: @profile.errors, status: :unprocessable_entity }
        end
    end
  end

  def step1
    @profile = Profile.new(:user_id => (params[:id]))
    respond_to do |format|
      format.html
      format.json { render json: @profile }
    end
  end
  def step2
    @profile = Profile.new(:user_id => (params[:id]))
    respond_to do |format|
      format.html
      format.json { render json: @profile }
    end
  end
end
