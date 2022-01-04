class AddAdminToUsers < ActiveRecord::Migration[7.0]
  # 管理ユーザー識別属性、デフォルトはfalse
  def change
    add_column :users, :admin, :boolean, default: false
  end
end
