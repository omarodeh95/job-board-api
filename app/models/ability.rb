class Ability
  include CanCan::Ability

  def initialize(user)

    if user.admin?
      #User with administration privileges can manage everything
      can :manage, :all
    else
      

      #Recruiter can only manage their job posts
      can [:update, :destroy], JobPost do |post|
        post.user == user
      end
      #Job seeker can only manage their job application
      can [:destroy, :show], JobApplication do |app|
        app.user == user
      end

      #Recruiter can show their job application
      can [:show], JobApplication do |app|
        app.job_post.user == user
      end

  end
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
