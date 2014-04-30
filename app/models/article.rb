class Article < ActiveRecord::Base
  
  dragonfly_accessor :image 

  belongs_to :user
  has_many :comments
  
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true, uniqueness: true
  validates :body, length: { minimum: 3 }
end
