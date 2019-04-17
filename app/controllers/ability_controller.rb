class AbilityController < ApplicationController
  

  def user_ability
  	@users = User.all
  end

  def make_admin
  	@user = User.find(params[:user_id])
  	@user.update(role: "admin")
  	@user.save
  	redirect_to user_ability_path
  end

end
