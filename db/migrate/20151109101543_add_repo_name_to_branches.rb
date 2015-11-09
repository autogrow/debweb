class AddRepoNameToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :repo_name, :string
  end
end
