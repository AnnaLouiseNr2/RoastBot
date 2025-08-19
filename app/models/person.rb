class Person < ApplicationRecord
  belongs_to :user
  has_many :chats, dependent: :destroy

  validates :name, :fun_facts, presence: true
  attribute :image, :string, default: "https://www.ledr.com/colours/white.jpg"
end
