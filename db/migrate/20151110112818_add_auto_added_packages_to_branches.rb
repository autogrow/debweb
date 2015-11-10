class AddAutoAddedPackagesToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :auto_added_packages, :text
  end
end
