class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :person
  has_many :messages, dependent: :destroy
end
