class Posting < ActiveRecord::Base
	validates :title, presence: true,
                    length: { minimum: 5 }
  has_one :job_application, dependent: :destroy

  def applied?
    job_application and job_application.id and job_application.date_sent
  end
end
