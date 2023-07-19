class AddNameAndRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :string
  end
end
