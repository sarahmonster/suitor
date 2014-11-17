class Offer < ActiveRecord::Base
  belongs_to :posting
  has_one :user, through: :posting
end
