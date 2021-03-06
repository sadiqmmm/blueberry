class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
       
      if user.admin?
        can :manage, :all
       
      else # Guest / Visitor can only read Articles and there comments
        can :read, Article
        can :read, Comment
        can :create, Comment
        #can [:index, :show, :new, :create, :edit, :update, :destroy], :all  # working...
       end

      if user.authenticated? # Authenticad users can index and show articles and can comment an artilcle
        can :read, Article
        can :read, Comment
        can :create, Comment
      end

      if user.moderator?
        can :read, Article
        can :read, Comment
        can :update, Comment do |comment|
          comment && comment.user == user || user.moderator?
        end
      end
       


    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end
