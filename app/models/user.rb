class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :people,  dependent: :destroy
  has_many :chats,   dependent: :destroy
  # has_many :messages, through: :chats


DEFAULT_PEOPLE = [
  { name: "Elon Musk", image: "https://upload.wikimedia.org/wikipedia/commons/9/99/Elon_Musk_Colorado_2022_%28cropped2%29.jpg", fun_facts: "CEO mode." },
  { name: "Jeff Bezos", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Jeff_Bezos-171025-F-PP655-236_%2839479699761%29_%28cropped%29.jpg/1200px-Jeff_Bezos-171025-F-PP655-236_%2839479699761%29_%28cropped%29.jpg", fun_facts: "Prime time." },
  { name: "J.K. Rowling", image: "https://upload.wikimedia.org/wikipedia/commons/5/5d/J._K._Rowling_2010.jpg", fun_facts: "Wizarding words." },
  { name: "Mark Zuckerberg", image:"https://upload.wikimedia.org/wikipedia/commons/c/c4/Mark_Zuckerberg_F8_2018_Keynote_%28cropped%29.jpg", fun_facts: "Socially networked." },
  { name: "Taylor Swift", image: "https://upload.wikimedia.org/wikipedia/commons/6/6c/Taylor_Swift_2019_by_Gage_Skidmore.jpg", fun_facts: "Era after era." },
  { name: "Warren Buffett", image: "https://upload.wikimedia.org/wikipedia/commons/5/51/Warren_Buffett_KU_Visit.jpg", fun_facts: "Oracle of Omaha." }
].freeze

  def create_default_people
    return unless people.empty?
    DEFAULT_PEOPLE.each do |attrs|
      people.create(attrs)
    end
  end
end
