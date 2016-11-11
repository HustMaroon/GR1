class TestsController < ApplicationController
	before_action :logged_in_user, :loggin_as_teacher

	def new
	end

	def create
		test = current_user.tests.new(test_params)
		if test.save
			flash[:success] = "test successfully created"
			redirect_to test
		else
			flash[:warming] = "sorry,something went wrong"
		end
	end

	def show
		@test = Test.find(params[:id])
	end

	def destroy
	end

	def index
		@tests = current_user.tests.all
	end

private
	def test_params
		params.require(:test).permit(:name, :time)
	end
end
