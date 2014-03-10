# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
	before do
		@user = User.new(name: "Example User", email: "user@example.com",
						 password: "foobar", password_confirmation: "foobar")
	end

	subject { @user }

	#その属性が存在するかどうかチェック（例えば、:foobarという属性は存在しない）
	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }

	it { should be_valid }

	#存在性の検証（値がblankのときにエラーとなるか）
	#validatesが切られていないとblankでもエラーにならないので、テストに失敗する
	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end
	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end
	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end

	#パスワードとパスワードの確認が一致するかどうあチェック
	describe "when password doesn't match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	#パスワードの確認がnillの場合にエラーとなるかチェック
	describe "when password confirmation is nil" do
		before { @user.password_confirmation = nil }
		it { should_not be_valid }
	end

	#長さの検証
	describe "when name is too long" do
		before { @user.name = "a" * 51 }
		it { should_not be_valid }
	end

	#emailのフォーマットをチェック、正規表現の指定が間違ってると失敗するはず
	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org first.last@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				@user.should be_valid
			end
		end
	end

	#同じアドレスを登録しようとしたときにvalidate:falseになればok
	#大文字小文字を区別していないこともチェック
	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

#############################################################################
	#authenticateメソッドによって認証されればユーザーが返され、
	#認証されない場合はfalseが返される
	#authenticateメソッドの結果としてUserオブジェクトが応答されればok
	it { should respond_to(:authenticate) }

	describe "return value of authenticate method" do
		#dbに事前に保存することでfind_by_emailメソッドが動作するようになる
		before { @user.save }

		#found_user:emailで検索した結果のユーザー（つまり@user）を格納
		let(:found_user) { User.find_by_email(@user.email) }

		#found_user.authenticate(@user.password):入力したパスワードが
		#dbのパスワードと一致していればそのユーザーを返す
		#一致しなければfalseを返す
		#つまり"@user == @user"になってればok
		describe "with valid password" do
			it { should == found_user.authenticate(@user.password) }
		end

		#found_user.authenticate("invalid"):falseを返却
		#"@user == false"となる
		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }
			it { should_not == user_for_invalid_password }
			#specify:itと同じ
			specify { user_for_invalid_password.should be_false }
		end
	end

	#パスワードが６文字以上であること
	describe "with a password that's too short" do
		before { @user.password = @user.password_confirmation = "a" * 5 }
		it { should be_invalid }
	end

end















