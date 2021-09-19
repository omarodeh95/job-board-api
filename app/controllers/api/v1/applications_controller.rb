class Api::V1::ApplicationsController < ApplicationController
    
    before_action :authenticate_user!
    before_action :set_user
    

    def index
        @job_posts = @user.job_posts
        @job_post = @job_posts.find_by(user_id: @user.id, id: params[:my_job_post_id])                
        authorize! :update, @job_post
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
        @job_posts = @user.job_posts
        @job_post = @job_posts.find_by(user_id: @user.id, id: params[:my_job_post_id] )

        if @job_post.present?
            authorize! :update, @job_post
            @job_application = @job_post.job_applications.find_by(id: params[:id])            

            if @job_application.present?

                @job_application.status = 'Seen'
                NotifierMailer.with(user: @user, job_post: @job_post).status_updated.deliver_later
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
