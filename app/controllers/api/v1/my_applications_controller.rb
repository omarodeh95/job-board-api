class Api::V1::MyApplicationsController < ApplicationController
    
    before_action :authenticate_user!
    before_action :set_user
    
    
    def new        
        @job_application = JobApplication.new        
        render json: {data: @job_application}
    end

    def index
        @job_applications = @user.job_applications        

        if @job_applications.present?
            render json: {data: @job_applications}, status: :ok
        else
            render json: {message: "There is no Job applications"}, status: :ok
        end

    end

    def show
        @job_application = @user.job_applications.find_by(id: params[:id])
        authorize! :show, @job_application

        if @job_application.present?
            render json: {data: @job_application}, status: :ok
        else
            render json: {message: "Job application does not exists"}
        end

    end

    def create
        @job_post = JobPost.find_by(params[:job_post_id])        

        if @job_post.present?            
            @job_application = @job_post.job_applications.build(user_id: @user.id, resume: params[:resume])

            if @job_application.save
                render json: {message: "Job application created successfully"}, status: :created
            else
                render json: {message: @job_application.errors.full_messages.join(', ')}
            end

        else
            render json: {message: "Job does not exist"}
        end
    end
    
    def destroy
        @job_post = JobPost.find_by(params[:job_post_id])      

        if @job_post.present?
            @job_application = @job_post.job_applications.find_by(user_id: @user.id)
            authorize! :destroy, @job_application

            if @job_application.present?

                @job_application.destroy
                render json:{message: "Job application deleted"}, status: :ok

            else
                render json: {message: "Job application does not exists"}
            end

        else
            render json: {message: "Job does not exist"}
        end
    end 
    
    private

    def set_user        
        @user = current_user
    end

end
