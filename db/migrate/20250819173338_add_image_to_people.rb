class AddImageToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :image, :string, default: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZrQECMXyRq9IlO7BJY_xHXQ7MMMbarta1oQ&s"
  end
end
