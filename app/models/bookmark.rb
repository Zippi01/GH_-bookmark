class Bookmark < ApplicationRecord
  validates :link, presence: true
  belongs_to :category
end
