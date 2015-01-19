class Ability
  include CanCan::Ability

  def initialize(user)

    if user.nil?
      can :read, :all
    else
      can [:read, :create], :all
      can :create, Photo
      can [:update, :destroy], Photo, :user_id => user.id
      
    end
  end
end
