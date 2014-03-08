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
		@user = User.new(name: "Example User", email: "user@example.com")
	end

	subject { @user }

	#その属性が存在するかどうかチェック（例えば、:foobarという属性は存在しない）
	it { should respond_to(:name) }
	it { should respond_to(:email) }

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

end















