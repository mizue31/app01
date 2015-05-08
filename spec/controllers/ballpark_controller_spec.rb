require 'spec_helper'

describe BallparkController do
	it "display top page" do
		post :index, @params
		assigns[:rdc_servers].should_not be_nil
	end
end
