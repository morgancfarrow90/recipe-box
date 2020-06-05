class Createusers < ActiveRecord::Migration[5.1]

  def change
    create_table :users do |t|
      t.string :user_email
      t.string :password_digest
    end
  end

end
