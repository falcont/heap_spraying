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
    can :update, [Question, Answer, Comment], user_id: user.id
    cannot :vote_up, [Question, Answer], user_id: user.id
    cannot :vote_down, [Question, Answer],  user_id: user.id
    can :cancel_vote, [Question, Answer] , user_id: user.id
    can :best, [Answer], user_id: user.id
  end

end