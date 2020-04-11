class Bookmark < ApplicationRecord
  validates :link, presence: true
end
