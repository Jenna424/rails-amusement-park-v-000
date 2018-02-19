class User < ActiveRecord::Base
  has_secure_password

  has_many :rides
  has_many :attractions, through: :rides

  validates :name, presence: :true

  def mood
    if self.happiness && self.nausea # ensuring that neither attribute = nil
      if self.happiness != self.nausea
        self.happiness > self.nausea ? "happy" : "sad"
      else
        "The user's mood is neutralized; the user is equally happy and sad."
      end
    end
  end

end
# user instance has password attribute,
# even though users table has password_digest column.
# We get #password, #password= and #authenticate methods
