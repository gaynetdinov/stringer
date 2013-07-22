class AddGroupIdToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :group_id, :integer
  end
end
