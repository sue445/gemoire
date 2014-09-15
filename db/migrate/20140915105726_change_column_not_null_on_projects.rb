class ChangeColumnNotNullOnProjects < ActiveRecord::Migration
  def self.up
    change_column_null :projects, :repository_url, false
  end

  def self.down
    change_column_null :projects, :repository_url, true
  end
end
