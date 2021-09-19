class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        include ActionController::Helpers
        include CanCan::ControllerAdditions
        
        rescue_from CanCan::AccessDenied do |exception|
                render json: {alert: exception.message}
        end

        
        
end
