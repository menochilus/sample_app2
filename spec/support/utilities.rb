include ApplicationHelper

#def full_title(page_title)
#	base_title = "Ruby on Rails Tutorial Sample App"
#	if page_title.empty?
#		base_title
#	else
#		"#{base_title} | #{page_title}"
#	end
#end

def valid_signin(user)
	fill_in "Email",    with: user.email.upcase
	fill_in "Password", with: user.password
	click_button "Sign in"
end

def valid_signup
	fill_in "Name",         with: "Example user"
	fill_in "Email",        with: "user@example.com"
	fill_in "Password",     with: "foobar"
	fill_in "Confirmation", with: "foobar"
end

Rspec::Matchers.define :have_success_message do |message|
	match do |page|
		page.should have_selector('div.alert.alert-success', text: message)
	end
end

Rspec::Matchers.define :have_error_message do |message|
	match do |page|
		page.should have_selector('div.alert.alert-error', text: message)
	end
end

Rspec::Matchers.define :have_title do |message|
	match do |page|
		page.should have_selector('title', text: message)
	end
end

Rspec::Matchers.define :have_h1 do |message|
	match do |page|
		page.should have_selector('h1', text: message)
	end
end

