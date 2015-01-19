class Photo < ActiveRecord::Base
  validates :name, length: {minimum: 3}, uniqueness: true
  belongs_to :user
  has_many :likes
end
