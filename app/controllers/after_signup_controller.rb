class AfterSignupController < ApplicationController
	include Wicked::Wizard
	steps :business_info , :finish_info

	def show
	    @user = current_user
	    render_wizard
	end

	def update
	    @user = current_user
	    @user.update_attribute(:status, step.to_s) 
	    @user.update_attributes(user_params)
	    render_wizard @user
	    @user.update_attribute(:status, 'active') if step == steps.last
  	end

  	def edit
	   @user = current_user
	    render_wizard
  	end

	def finish_wizard_path
	  flash[:success] = "Thank You for Signing up with H-Design!"
	  user_path(current_user)
	end
  	
 private
 	def user_params
 		params.require(:user).permit(:company, :website, :license_no, :awards)
 	end
end
