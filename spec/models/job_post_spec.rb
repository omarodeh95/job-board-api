require 'rails_helper'

    describe JobPost, type: :model do

        it "Title can't be empty" do
            hr = User.create(email: "hr@outlook.com", password: "hrrrrrrrrr123")
            
            post = JobPost.create(user_id: hr.id, title: nil, description: "Dev-ops tasks")
            
            expect(post).to_not be_valid
        end

        it "Description can't be empty" do
            hr = User.create(email: "hr@outlook.com", password: "hrrrrrrrrr123")
            
            post = JobPost.create(user_id: hr.id, title: "Dev-ops", description: nil)
            
            expect(post).to_not be_valid
        end

        it "Belongs to user" do

            post = JobPost.create(user_id: nil, title: "Dev-ops", description: "Dev-ops tasks")

            expect(post).to_not be_valid

        end

    end