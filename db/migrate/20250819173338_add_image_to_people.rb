class AddImageToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :image, :string, default: "https://www.ledr.com/colours/white.jpg"
  end
end
