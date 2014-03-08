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

class User < ActiveRecord::Base
  attr_accessible :email, :name

  #presence:blank?メソッドで中身があるかどうかチェック、存在性の検証
  #length:長さのチェック
  validates :name, presence: true, length: { maximum: 50 }
  #VALID_EMAIL_REGEX：定数、大文字で始まる名前は定数を意味する
  #このパターンに一致するアドレスだけ有効となることをチェック	
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
end
