class Offer < ActiveRecord::Base
  belongs_to :posting
  has_one :user, through: :posting
  validates :posting, presence: true, uniqueness: true
end
