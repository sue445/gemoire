class AddIndexToRepositoryUrl < ActiveRecord::Migration
  def self.up
    add_index :projects, :remote_url
  end

  def self.down
    remove_index :projects, :remote_url
  end
end
