class Vote < ApplicationRecord
  belongs_to :user
  
  belongs_to :votable, polymorphic: true


  def positive
    self.rating += 1
  end

  def negative
    self.rating -= 1
  end

end
