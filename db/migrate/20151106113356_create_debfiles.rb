class CreateDebfiles < ActiveRecord::Migration
  def change
    create_table :debfiles do |t|
      t.string :name
      t.text :control
      t.string :version

      t.timestamps null: false
    end
  end
end
