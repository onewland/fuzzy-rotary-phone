class AddIndexOnChannelStatus < ActiveRecord::Migration
  def change
    add_index :matches, [:channel, :status]
  end
end
