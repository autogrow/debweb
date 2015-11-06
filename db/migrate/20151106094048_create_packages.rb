class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.integer :branch_id
      t.integer :debfile_id
      t.string :path

      t.timestamps null: false
    end
  end
end
