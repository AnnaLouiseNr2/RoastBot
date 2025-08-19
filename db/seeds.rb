# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Person.destroy_all

people = [
  { name: "Lara Venton",     fun_facts: "Owns 27 mismatched socks." },
  { name: "Miles Ronder",    fun_facts: "Talks to houseplants daily." },
  { name: "Sienna Karpov",   fun_facts: "Believes cereal is a soup." },
  { name: "Jonas Fletch",    fun_facts: "Never learned to whistle." },
  { name: "Amira Solven",    fun_facts: "Has a pet snail named Turbo." },
  { name: "Caius Trell",     fun_facts: "Can recite the alphabet backwards." },
  { name: "Nyla Bracks",     fun_facts: "Thinks pineapple pizza is elite cuisine." },
  { name: "Eren Malvik",     fun_facts: "Collects novelty keychains." },
  { name: "Tova Mirelle",    fun_facts: "Laughs at their own jokes first." },
  { name: "Kieran Doss",     fun_facts: "Claims to remember every dream vividly." }
]

Person.insert_all(people)


