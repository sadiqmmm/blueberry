class Article < ActiveRecord::Base
  include FriendlyId
  friendly_id :title, use: :slugged

  dragonfly_accessor :image 

  belongs_to :user
  has_many :comments, dependent: :destroy
  
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :body, length: { minimum: 3 }
end
