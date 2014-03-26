require 'spec_helper'

describe "Authentication" do
	subject { page }

	describe "signin page" do
		before { visit signin_path }

		#it { should have_selector('h1',    text: 'Sign in') }
		#it { should have_selector('title', text: 'Sign in') }
		it { should have_title('Sign in') }
		it { should have_h1('Sign in')}
	end

	#8.1.5
	describe "signin" do
		before { visit signin_path }
		let(:submit) { "Sign in" }
		before { click_button submit }

		describe "with invalid information" do		
			#it { should have_selector('title', text: 'Sign in') }
			it { should have_title('Sign in') }
			#it { should have_selector('div.alert.alert-error', text: 'Invalid') }
			#utilities.rbに定義
			it { should have_error_message('Invalid') }


			describe "after visiting another page" do
				before { click_link "Home" }
				#it { should_not have_selector('div.alert.alert-error') }
				it { should_not have_error_message }
			end

		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			#before do
			#	#大文字小文字を区別しないデータベースが
			#	#使用されている場合であってもユーザーを確実に検索できるように配慮してある
			#	fill_in "Email",    with: user.email.upcase
			#	fill_in "Password", with: user.password
			#	click_button "Sign in"
			#end
			#utilities.rbに定義
			before { valid_signin(user) }

			#it { should     have_selector('title', text: user.name) }
			it { should     have_title(user.name) }
			#it { should     have_selector('h1',    text: user.name) }
			it { should     have_h1(user.name) }
			it { should     have_link('Profile',   href: user_path(user)) }
			it { should_not have_link('Sign in',   href: signin_path) }
			it { should     have_link('Sign out',  href: signout_path) }

			#8.2.6
			describe "followed by signout" do
				before { click_link "Sign out" }
				it { should have_link('Sign in') }
			end

		end

	end

end
