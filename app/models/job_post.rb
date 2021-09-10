class JobPost < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    
    belongs_to :user
    has_many :job_applications, dependent: :destroy
    
    accepts_nested_attributes_for :job_applications
end
