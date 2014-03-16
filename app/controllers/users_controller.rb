class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		#ユーザー表示ページに移動
  		redirect_to @user
  	else
  		#入力エラーのときはnew.html.erbに飛ばす
  		render 'new'
  	end
  end

end
