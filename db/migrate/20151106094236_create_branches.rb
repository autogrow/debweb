class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :name
      t.integer :project_id
      t.string :component_name

      t.timestamps null: false
    end
  end
end
