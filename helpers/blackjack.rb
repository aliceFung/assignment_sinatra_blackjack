class Blackjack
  attr_reader :game

  SUITS= ["Hearts", "Clubs", "Spades", "Diamonds"]

  def initialize(state = nil)
    if state
      @game = state
      @deck = @game[0]
      @hand = @game[1]
      @dealer = @game[2]

    else
      @deck = generate_deck
      @hand, @dealer = [], []
      @game = [@deck, @hand, @dealer]
      deal_initial
    end
  end

  def generate_deck
    deck = []
    values = (1..13).to_a

    52.times do |i|
      deck << {"suit" => SUITS[i%4], "value" => values[i%13]}
    end

    deck.shuffle!
  end

  def deal_initial
    2.times do |c|
      @hand << @deck.pop
      @dealer << @deck.pop
    end

    # blackjack? = true if hand_value(@hand) == 21
  end

  def hit

    @hand << @deck.pop

  end

  def render
    special_names = {1 => "Ace", 11 => "Jack", 12 => "Queen", 13 => "King"}

    str = "Your Cards:<br>"

    @hand.each do |card|
      if special_names[card["value"]]
        str += "#{special_names[card["value"]]} of #{card["suit"]}<br>"
      else
        str += "#{card["value"]} of #{card["suit"]}<br>"
      end
    end

    str += "Dealer's Cards:<br>"

    current_hand = @dealer
    @dealer[1..-1].each do |card|
      if special_names[card["value"]]
        str += "#{special_names[card["value"]]} of #{card["suit"]}<br>"
      else
        str += "#{card["value"]} of #{card["suit"]}<br>"
      end
    end
    str += "And an unknown card."

    str
  end

  def hand_value(arr = @hand)
    total = 0
    aces = 0


    #adding everything but the ace
    arr.each do |card|
      total += card["value"] if (2..10).include?(card["value"])
      total += 10           if (11..13).include?(card["value"])
      if card["value"] == 1
        total += 11
        aces += 1
      end
    end

    while total > 21 && aces > 0
      total -= 10
      aces -= 1
    end

    total
  end

  def check_gameover?
      bust?(@hand) || win?
  end


  def bust?(arr = @hand)
    hand_value(arr) > 21

  end

  def win?
    bust?(@dealer) || ((hand_value(@hand) && hand_value(@hand)<=21) > hand_value(@dealer))
  end

  def blackjack?
    hand_value(@hand) > 21
  end

  def dealer_move
    until hand_value(@dealer)> 17
      @dealer << @deck.pop
    end
  end




end













