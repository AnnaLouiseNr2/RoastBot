class AddColumnsToChats < ActiveRecord::Migration[7.1]
  def change
    add_column :chats, :tone, :text
    add_column :chats, :format, :text
  end
end
