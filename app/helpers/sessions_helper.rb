module SessionsHelper

	def sign_in(user)
		#dbのremember_tokenをcookiesハッシュに格納
		#permanent : 自動的に期限が20.years.from.nowになる
		cookies.permanent[:remember_token] = user.remember_token
		#current_user=(user)メソッドを呼び出してるのと同じ
		#selfがないとただのローカル変数を作るだけ
		self.current_user = user
	end

	#current_userがnilでない場合にユーザーがサインイン
	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		#@current_user = @current_user || User.find_by_remember_token(cookies[:remember_token]) 
		#初回はremember_tokenメソッドを呼び出し、それ以降は@current_userを返す
		@current_user ||= User.find_by_remember_token(cookies[:remember_token]) 
		
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

end
