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
	before { @user = User.new(name: "Example User", email: "user@example.com") }
	subject { @user }
	#その属性が存在するかどうかチェック（例えば、:foobarという属性は存在しない）
	it { should respond_to(:name) }
	it { should respond_to(:email) }
end
