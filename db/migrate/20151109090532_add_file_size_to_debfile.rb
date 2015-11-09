class AddFileSizeToDebfile < ActiveRecord::Migration
  def change
    add_column :debfiles, :file_size, :integer
  end
end
