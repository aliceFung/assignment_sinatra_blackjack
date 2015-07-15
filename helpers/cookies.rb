module Cookies

  def save_game(arr)
    response.set_cookie("game_state", arr.to_json)
  end

  def load_game
    cookie = request.cookies["game_state"]
    unless (cookie.nil? || cookie == "")
      JSON.parse(cookie)
    end
  end

  def bankroll
    unless (session["bankroll"].nil?)
      return session["bankroll"].to_i
    else
      session["bankroll"] = 100.to_s
      return 100
    end
  end

  def set_bankroll(amt)
    session["bankroll"] = amt.to_s
  end

end