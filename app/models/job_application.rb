class JobApplication < ApplicationRecord
    belongs_to :user
    belongs_to :job_post
    validates :user_id, uniqueness: {scope: :job_post_id}
    validates :status, acceptance: { accept: ['Not Seen', 'Seen'] }   
    
    #using active storage for resume update
    has_one_attached :resume
end
