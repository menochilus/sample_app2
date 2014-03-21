class SessionsController < ApplicationController

	def new
	end

	def create
		#user : 入力したメールアドレスでdbを検索し、あればそのユーザを格納。なければfalse
		user = User.find_by_email(params[:session][:email].downcase)
		#userとuser.au〜がそれぞれtrueかどうかを判定
		#user.au~ ; 入力したパスワードをハッシュ化して、
		#userのパスワードダイジェストと比較して認証する。
		#認証okならユーザを返す。ngならfalse
		if user && user.authenticate(params[:session][:password])
			#ユーザー表示ページに移動
	  		redirect_to user_path(user)
		else
			#flash[:error]だと、new画面から他の画面に飛んだ時にエラーメッセージが
			#残ったままになってしまう
			#renderはリクエストが発行されないため、リンクを押して次の画面に遷移するときに
			#初めてリクエストが発行される
			#そこまではメッセージが残り続ける	
			flash.now[:error] = 'Invalid email/password combination' #誤りあり！
			render 'new'
		end
	end

	def destroy
	end

end
