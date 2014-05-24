class Interview < ActiveRecord::Base
  belongs_to :posting
  validates :posting, presence: true
end
