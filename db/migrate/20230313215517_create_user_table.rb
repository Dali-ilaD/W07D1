class CreateUserTable < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null:false, uniqueness:true
      t.string :password_digest, null:false
      t.string :session_token, null:false, uniqueness:true

      
      t.timestamps
    end
    add_index :users, :session_token
  end

end
