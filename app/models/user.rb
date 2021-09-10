class User < ApplicationRecord

    # Include default devise modules., :omniauthable :recoverable,:rememberable, :trackable,, :confirmable

    devise :database_authenticatable, :registerable, :validatable

    include DeviseTokenAuth::Concerns::User

    has_many :job_applications, dependent: :destroy
    has_many :job_posts, dependent: :destroy
    
    accepts_nested_attributes_for :job_posts
    accepts_nested_attributes_for :job_applications

end
