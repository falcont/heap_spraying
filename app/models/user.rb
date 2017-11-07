class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy


  def author?(obj)
    self.id == obj.user_id
  end

end
