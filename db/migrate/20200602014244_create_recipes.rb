class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :main_ingrediant
      t.text  :instructions
      t.text  :notes
      t.integer :user_id
      t.integer :genre_id
    end
  end
end
