
step 'start ballpark' do
	Capybara.app_host = 'http://localhost:3000/ballpark'
end

step 'open top page' do
	visit '/'
end

step 'input :val to :fld' do |val, fld|
	fill_in fld, :with => val
end

step 'click :btn button' do |btn|
	first(:button, btn).click
end

step 'display character :str' do |str|
	expect(page).to have_content(str)
end

step 'display result character :str' do |str|
	expect(page).to have_content(str)
	current_path = URI.parse(current_url).path
	current_path.should == '/ballpark/'
#	save_and_open_page
end
