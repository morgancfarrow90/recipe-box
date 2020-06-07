class AddIngrediantsColumn < ActiveRecord::Migration
  def change
    add_column :recipes, :ingredients, :string
  end
end
