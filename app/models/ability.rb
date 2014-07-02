class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin == true
      can :manage, :all
    else
      can :show, Roll, :user_id => user.id
      can :show, Photo do |photo|
        photo.roll.user.id == user.id
      end
      can :create, Roll, :user_id => user.id
      can :create, Photo do |photo|
        photo.roll.user.id == user.id
      end
    end
  end
end
