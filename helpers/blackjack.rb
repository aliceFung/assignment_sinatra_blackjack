class Blackjack

  SUITS= ["Hearts", "Clubs", "Spades", "Diamonds"]

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
    values = (1..13).to_a

    52.times do |i|
      deck << {suit: SUITS[i%4], value: values[i%13]}
    end

    deck.shuffle!
  end

  def deal_initial
    2.times do |c|
      @hand << @deck.pop
      @dealer << @deck.pop
    end
  end

  def pretty_print
    special_names = {1 => "Ace", 11 => "Jack", 12 => "Queen", 13 => "King"}
    current_hand = @hand

    str = "Your Cards:\n"

    current_hand.each do |card|
      if special_names[card[:value]]
        str += "#{special_names[card[:value]]} of #{card[:suit]}\n"
      else
        str += "#{card[:value]} of #{card[:suit]}\n"
      end
    end

    str += "Dealer's Cards:\n"

    current_hand = @dealer
    @dealer[1..-1].each do |card|
      if special_names[card[:value]]
        str += "#{special_names[card[:value]]} of #{card[:suit]}\n"
      else
        str += "#{card[:value]} of #{card[:suit]}\n"
      end
    end
    str += "And an unknown card."

    str
  end




end