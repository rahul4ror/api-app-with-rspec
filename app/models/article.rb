class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true
end
