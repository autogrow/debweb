class AddModifiedAtToDebfile < ActiveRecord::Migration
  def change
    add_column :debfiles, :modified_at, :datetime
  end
end
