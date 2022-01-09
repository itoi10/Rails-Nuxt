class AddActivatedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :activated, :boolean, null: false, default: false
  end
end
