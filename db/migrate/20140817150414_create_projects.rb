class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :branch
      t.string :ssh_url
      t.string :commit
      t.timestamps
    end

    add_index :projects, [:name, :branch], unique: true
  end

  def self.down
    drop_table :projects
  end
end
