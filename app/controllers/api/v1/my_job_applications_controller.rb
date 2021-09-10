class Api::V1::MyJobApplicationsController < ApplicationController
    
    before_action :authenticate_user!
    before_action :set_user

    def index
        @job_post = JobPost.find_by(user_id: @user.id, id: params[:my_job_post_id])

        if @job_post.present?            
            @job_applications = @job_post.job_applications

            if @job_applications.present?
                render json: {data: @job_applications}, status: :ok
            else
                render json: {message: "No job application are not made yet"}
            end
        else
            render json: {message: "job does not exist"}
        end
    end

    def show
        @job_post = JobPost.find_by(user_id: @user.id, id: params[:my_job_post_id] ).job_applications

        if @job_post.present?
            @job_application = @job_post.find_by(id: params[:id])

            if @job_application.present?
                @job_application.status = 'Seen'
                @job_application.save
                render json: {data: @job_application}, status: :ok
            else
                render json: {message: "Job application does not exists"}
            end
        else
            render json: {message: "job does not exist"}
        end
    end

    private

    def set_user
        @user = current_user
    end

end
