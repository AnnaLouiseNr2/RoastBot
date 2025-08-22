class ChangeImageDefaultOnPeople < ActiveRecord::Migration[7.1]
  def change
    change_column_default :people, :image, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZrQECMXyRq9IlO7BJY_xHXQ7MMMbarta1oQ&s"
  end
end
