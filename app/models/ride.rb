class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    enough_tickets, tall_enough = self.meet_requirements
    # enough_tickets, tall_enough = [enough_tickets, tall_enough]
    # enough_tickets local variable = enough_tickets first element in array, and
    # tall_enough local variable = tall_enough second element in array
    if enough_tickets && tall_enough # true && true is true
      self.start_ride
    elsif tall_enough && !enough_tickets
      "Sorry. " << self.ticket_shortage
    elsif enough_tickets && !tall_enough
      "Sorry. " << self.too_short
    else
      "Sorry. " << self.ticket_shortage << " " << self.too_short
    end
  end

  def meet_requirements
    enough_tickets, tall_enough = false

    if self.user.tickets >= self.attraction.tickets
      enough_tickets = true
    end

    if self.user.height >= self.attraction.min_height
      tall_enough = true
    end

    [enough_tickets, tall_enough]
  end

  def start_ride
    updated_tickets = self.user.tickets - self.attraction.tickets
    updated_nausea = self.user.nausea + self.attraction.nausea_rating
    updated_happiness = self.user.happiness + self.attraction.happiness_rating

    self.user.update(
      tickets: updated_tickets,
      nausea: updated_nausea,
      happiness: updated_happiness
    )
    
    "Thanks for riding the #{self.attraction.name}!"
  end

  def ticket_shortage
    "You do not have enough tickets to ride the #{self.attraction.name}."
  end

  def too_short
    "You are not tall enough to ride the #{self.attraction.name}."
  end
end
