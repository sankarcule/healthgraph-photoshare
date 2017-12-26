class AddColumnToPost < ActiveRecord::Migration[5.1]
  def change
    add_reference :posts, :user, foreign_key: true
    add_column :users, :name, :string
  end
end
