require 'spec_helper'
describe String do
	describe '#<<' do
		example 'add strings' do
			s = "ABC"
			s << "D"
			expect(s.size).to eq(4)
		end
	end
end
