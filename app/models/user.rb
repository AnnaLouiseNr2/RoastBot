class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :people,  dependent: :destroy
  has_many :chats,   dependent: :destroy
  # has_many :messages, through: :chats

DEFAULT_PEOPLE = [
  { name: "Elon Musk", fun_facts: "CEO mode." },
  { name: "Jeff Bezos", fun_facts: "Prime time." },
  { name: "J.K. Rowling", image: "https://upload.wikimedia.org/wikipedia/commons/5/5d/J._K._Rowling_2010.jpg", fun_facts: "Wizarding words." },
  { name: "Mark Zuckerberg", fun_facts: "Socially networked." },
  { name: "Taylor Swift", fun_facts: "Era after era." },
  { name: "Warren Buffett", image: "https://upload.wikimedia.org/wikipedia/commons/5/51/Warren_Buffett_KU_Visit.jpg", fun_facts: "Oracle of Omaha." }
].freeze

  def create_default_people
    return unless people.empty?
    DEFAULT_PEOPLE.each do |attrs|
      people.create(attrs)
    end
  end

end
