class Person < ApplicationRecord
  belongs_to :user
  has_many :chats, dependent: :destroy

  validates :name, :fun_facts, presence: true
end
