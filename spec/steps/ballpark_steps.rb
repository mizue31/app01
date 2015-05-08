step 'start ballpark' do
	Capybara.app_host 'http://app00.herokuapp.com/'
end

step 'open top page' do
	Capybara.app_host '/ballpark'
end

step 'input :val to :fld' do |val, fld|
	fill_in(fld, :with => val)
end

step 'click :btn button' do |btn|
	first(:button, btn).click
end

step 'display character :str' do |str|
	expect(page).to have_content(str)
end

step 'display calc result' do
	current_path = URI.(current_url).path
	current_path.should == '/ballpark/calc'
end
