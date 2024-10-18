class ChangeDefaultForUsersRolesMask < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :roles_mask, :integer, :default => 1
  end
end
