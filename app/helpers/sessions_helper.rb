module SessionsHelper

	def sign_in(user)
		#dbのremember_tokenをcookiesハッシュに格納
		#permanent : 自動的に期限が20.years.from.nowになる
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end
end
