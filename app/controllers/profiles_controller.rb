class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @profile = current_user.profile
  end

  def update
    profile_params = params.require(:profile).permit(:cover_photo, :birth_place,
                          :residence, :phone)
    if current_user.profile.update(profile_params)
      redirect_to current_user
    else
      flash[alert] = "Something went wrong."
      render :edit
    end
  end
end
