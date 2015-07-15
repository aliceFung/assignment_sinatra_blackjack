module Cookies

  def save_game(arr)
    response.set_cookie("game_state", arr.to_json)
  end

  def load_game
    cookie = request.cookies["game_state"]
    JSON.parse(cookie) if cookie
  end

end