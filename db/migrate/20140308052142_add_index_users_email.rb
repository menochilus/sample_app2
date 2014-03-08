class AddIndexUsersEmail < ActiveRecord::Migration
	def change
		add_index :users, :email, unique: true
	end

#  def up
#  end

#  def down
#  end
end
