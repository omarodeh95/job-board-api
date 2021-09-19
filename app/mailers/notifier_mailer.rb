class NotifierMailer < ApplicationMailer
    def status_updated
        @user = params[:user]
        @job_post = params[:job_post]
        
        mail(
            to: @user.email,
            subject: @job_post.title,
        )


    end
end
