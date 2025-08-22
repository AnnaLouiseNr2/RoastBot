class AddColumnsToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :tone, :text
    add_column :messages, :format, :text
  end
end
