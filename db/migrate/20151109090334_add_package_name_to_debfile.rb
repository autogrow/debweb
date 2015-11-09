class AddPackageNameToDebfile < ActiveRecord::Migration
  def change
    add_column :debfiles, :package_name, :string
  end
end
