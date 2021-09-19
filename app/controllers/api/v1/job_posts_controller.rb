class Api::V1::JobPostsController < ApplicationController

    before_action :authenticate_user!
    

    def index
        @job_posts = JobPost.all      

        if @job_posts.present?            
            render json: {data: @job_posts.as_json(only: [:title, :created_at, :updated_at])}, status: :ok
        else
            render json: {message: "No job post is made yet"}
        end

    end

    def show
        @job_post = JobPost.find_by(id: params[:id])                

        if @job_post.present?            
            render json: {data: @job_post}, status: :ok
        else
            render json: {message: "Job post does not exists"}
        end
        
    end        
end
