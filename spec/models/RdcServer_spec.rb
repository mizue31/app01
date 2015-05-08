require 'spec_helper'

describe RdcServer, :type => :model do
	it "isn't valid without typename and num1" do
		data = RdcServer.new
		expect(data).not_to be_valid
	end
	it "isn't valid with greater than 10 in num1" do
		data = RdcServer.new
		data.num1 = 11
		data.typename = "typename1"
		expect(data).not_to be_valid
	end
	it "isn't valid without typename" do
		data = RdcServer.new
		data.num1 = 10
		expect(data).not_to be_valid
	end
	it "is valid" do
		data = RdcServer.new
		data.num1 = 10
		data.typename = "typename1"
		expect(data).to be_valid
	end
end
