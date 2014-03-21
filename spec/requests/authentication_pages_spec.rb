require 'spec_helper'

describe "Authentication" do
	subject { page }

	describe "signin page" do
		before { visit signin_path }

		it { should have_selector('h1',    text: 'Sign in') }
		it { should have_selector('title', text: 'Sign in') }
	end

	describe "signin" do
		before { visit signin_path }
		let(:submit) { "Sign in" }
		before { click_button submit }

		describe "with invalid information" do		
			it { should have_selector('title', text: 'Sign in') }
			it { should have_selector('div.alert.alert_error', text: 'Invalid') }
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				#大文字小文字を区別しないデータベースが
				#使用されている場合であってもユーザーを確実に検索できるように配慮してある
				fill_in "Email",    with: user.email.upcase
				fill_in "Password", with: user.password
			    click_button "Sign in"
			end

			it { should     have_selector('title', text: user.name) }
			it { should     have_selector('h1',    text: user.name) }
			it { should     have_link('Profile',   href: user_path(user)) }
			it { should_not have_link('Sign in',   href: signin_path) }
			it { should     have_link('Sign out',  href: signout_path) }
			
		end

	end

end
