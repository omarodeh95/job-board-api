class Api::V1::MyJobPostsController < ApplicationController
    
    before_action :authenticate_user!
    before_action :set_user

    def new
        @job_post = JobPost.new
        render json: {data: @job_post.as_json(only: [:title, :description])}, status: :ok
    end

    def index
        @job_posts = @user.job_posts        

        if @job_posts.present?            
            render json: {data: @job_posts}, status: :ok
        else
            render json: {message: "No job post is made yet"}
        end

    end

    def show
        @job_posts = @user.job_posts

        if @job_posts.present?
            @job_post = @job_posts.find_by(id: params[:id])            

            if @job_post.present?                
                render json: {data: @job_post}, status: :ok
            else
                render json: {message: "Job post does not exists"}
            end

        else
            render json: {message: "Job post does not exists"}
        end

    end

    def create
        @job_post = @user.job_posts.build(job_post_params)

        if @job_post.save
            render json: {message: "Job post created successfully"}, status: :created
        else
            render json: {message: @job_post.errors.full_messages.join(', ')}
        end

    end

    def update
        @job_posts = @user.job_posts

        if @job_posts.present?
            @job_post = @job_posts.find_by(id: params[:id])
            authorize! :update, @job_post

            if @job_post.present?

                if @job_post.update(job_post_params)
                    render json: {message: "Job post saved successfully"}, status: :ok
                else 
                    render json: {message: @job_post.errors.full_messages.join(', ')}
                end

            else
                render json: {message: "job post does not exists"}
            end

        else
            render json: {message: "job post does not exists"}
        end

    end
    
    def destroy
        @job_posts = @user.job_posts        

        if @job_posts.present?
            @job_post= @job_posts.find_by(id: params[:id])            
            authorize! :destroy, @job_post

            if @job_post.present?
                
                @job_post.destroy
                render json:{message: "Job post deleted"}, status: :ok

            else
                render json: {message: "job post does not exists"}
            end
            
        else
           render json: {message: "job post does not exists"}
        end
        
    end 

    private
    
    def job_post_params 
        params.require(:my_job_post).permit(:title, :description)
    end

    def set_user
        @user = current_user
    end

end
