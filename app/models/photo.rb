class Photo < ActiveRecord::Base

  has_attached_file :image, :styles => { :medium => "600x600>", :thumb => "100x100>"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :name, length: {minimum: 3}, uniqueness: true
  belongs_to :user
  has_many :likes

end
