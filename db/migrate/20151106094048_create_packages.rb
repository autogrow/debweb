class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.integer :branch_id
      t.string :version
      t.string :path
      t.text :control

      t.timestamps null: false
    end
  end
end
