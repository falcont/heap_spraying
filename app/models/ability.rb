class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user 
      user.admin ? admin_abilities : user_abilities  
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment]
    can :update, [Question, Answer, Comment], user: user.id
    can :vote_up, [Question, Answer]
    can :vote_down, [Question, Answer]
    can :cancel_vote, [Question, Answer]
    can :best, [Answer]
  end

end