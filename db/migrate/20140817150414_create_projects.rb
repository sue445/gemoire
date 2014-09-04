class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name      , null: false
      t.string :branch    , null: false, default: "master"
      t.string :remote_url, null: false
      t.string :commit
      t.timestamps
    end

    add_index :projects, [:name, :branch], unique: true
  end

  def self.down
    drop_table :projects
  end
end
