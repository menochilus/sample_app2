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
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  #email属性を小文字にして一意性を保証する	
  #before_save { |user| user.email = email.downcase }
  before_save { email.downcase! }
  #remember_tokenを生成（ユーザーが保存される直前）
  before_save :create_remember_token

  #presence:blank?メソッドで中身があるかどうかチェック、存在性の検証
  #length:長さのチェック
  validates :name, presence: true, length: { maximum: 50 }
  #validates :password, presence: true, length: { minimum: 6 }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  #VALID_EMAIL_REGEX：定数、大文字で始まる名前は定数を意味する
  #format:パターンに一致するアドレスだけ有効となることをチェック
  #uiqueness:一意性チェック
  #case_sensitive: false:大文字小文字を区別しない
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }

  #Userモデルの内部でしか使用しない
  private

    def create_remember_token
      #Ruby標準ライブラリのSecureRandomモジュールにある
      #urlsafe_base64メソッドを使用して記憶トークンをカスタム生成
      #長さ16のランダムな文字列を返す
      #selfがないとローカル変数として作成されてしまう
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
