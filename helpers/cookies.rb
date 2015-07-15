module Cookies

  def save_game(arr)
    response.set_cookie(:game_state, arr.to_json)
  end

  def load_game
    JSON.parse(request.cookies[:game_state])
  end

end