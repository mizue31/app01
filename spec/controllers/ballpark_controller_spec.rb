require 'spec_helper'

describe BallparkController do
	it "display top page" do
		post :index, @params
		expect(assigns[:rdc_servers]).not_to be_nil
	end
end
