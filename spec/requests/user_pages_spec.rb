require 'spec_helper'

describe "User Pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		#it { should have_selector('h1',    text: 'Sign up') }
		#it { should have_selector('title', text: full_title('Sign up')) }
		it { should have_title(full_title('Sign up')) }
		it { should have_h1('Sign up') }

	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		#it { should have_selector('h1',    text: user.name) }
		#it { should have_selector('title', text: user.name) }
		it { should have_title(user.name) }
		it { should have_h1(user.name) }

	end

	#7.2.1
	describe "signup page" do
		before { visit signup_path }
		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end

			describe "after submission" do
				before { click_button submit }

				#it { should have_selector('title', text: 'Sign up') }
				it { should have_title('Sign up') }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			#before do
			#	fill_in "Name",        with: "Example user"
			#	fill_in "Email",       with: "user@example.com"
			#	fill_in "Password",    with: "foobar"
			#	fill_in "Confirmation",with: "foobar"
			#end
			before { valid_signup }

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by_email('user@example.com') }

				#it { should have_selector('title', text: user.name) }
				it { should have_title(user.name) }
				#flash[:success] = "Welcome to the Sample App!"の確認
				#it { should have_selector('div.alert.alert-success', text: 'Welcome') }
				it { should have_success_message('Welcome') }
				#8.2.5
				it { should have_link('Sign out') }

			end

		end
	end

end
