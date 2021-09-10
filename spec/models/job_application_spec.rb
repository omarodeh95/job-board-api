require 'rails_helper'

describe JobApplication, type: :model do

    it "Must belong to a user" do
        hr = User.create(email: "hr@outlook.com", password: "hrrrrrrrrr123")
        post = JobPost.create(user_id: hr.id,title:"Dev-ops", description: "Dev-ops tasks")

        app = JobApplication.create(user_id: nil, job_post_id: post.id)
        expect(app).to_not be_valid
    end

    it "Must belong to a job post" do
        applicant = User.create(email: "applicant@outlook.com", password: "applicant123")

        app = JobApplication.create(user_id: applicant.id, job_post_id: nil)
        expect(app).to_not be_valid
    end    

    it "Default value of status is 'Not Seen'" do

        applicant = User.create(email: "applicant@outlook.com", password: "applicant123")
        hr = User.create(email: "hr@outlook.com", password: "hrrrrrrrrr123")        
        post = JobPost.create(user_id: hr.id,title:"Dev-ops", description: "Dev-ops tasks")

        app = JobApplication.create(user_id: hr.id, job_post_id: post.id)
        expect(app.status).to eq('Not Seen')
    end

    it "Accepted status values are 'Not Seen' & 'Seen' only" do
        hr = User.create(email: "hr@outlook.com", password: "hrrrrrrrrr123")
        post = JobPost.create(user_id: hr.id,title:"Dev-ops", description: "Dev-ops tasks")

        applicant1 = User.create(email: "applicant1@outlook.com", password: "applicant1123")
        applicant2 = User.create(email: "applicant2@outlook.com", password: "applicant2123")
        applicant3 = User.create(email: "applicant@outlook.com", password: "applicant3123")

        app1 = JobApplication.create(user_id: applicant1.id, job_post_id: post.id, status: 'Not Seen')
        app2 = JobApplication.create(user_id: applicant2.id, job_post_id: post.id, status: 'Seen')
        app3 = JobApplication.create(user_id: applicant3.id, job_post_id: post.id, status: 'Some Value')

        expect(app1).to be_valid
        expect(app2).to be_valid
        expect(app3).to_not be_valid
    end
end