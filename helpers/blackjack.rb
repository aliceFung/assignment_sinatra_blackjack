class Blackjack

  def initialize(state = nil)
    if state
      @game = state
    else
      @deck = generate_deck
      @hand, @dealer = [], []
      @game = [@deck, @hand, @dealer]
    end
  end

def generate_deck
    deck = []

    suits = ["Hearts", "Clubs", "Spades", "Diamonds"]

    values = (1..13).to_a

    52.times do |i|
      deck << {suit: suits[i%4], value: values[i%13]}
    end

    deck
  end


end