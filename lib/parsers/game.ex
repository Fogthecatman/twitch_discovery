defmodule TwitchDiscovery.Parser.Game do
  use TwitchDiscovery.Parser.Base
  require Logger
  use Timex

  def db_key(id) do
    "games-" <> Integer.to_string(id)
  end

  def db_key(id, field) do
    "games-" <> Integer.to_string(id) <> "-" <> field
  end

  def id(game) do
    game["game"]["_id"]
  end

  def meta(game) do
    [{"id", id(game)},
     {"name", game["name"]}]
  end

  def filters(game) do
    [{"game",       game["game"]}]
  end

  # viewers = {game, [{184729423947, 3283}, {184729423947, 3283}]} # "viewers"
  def metrics(game) do
    [{"viewers", game["viewers"]},
     {"channels", game["channels"]}]
  end

  def capture(game) do
    id      = id(game)
    meta    = meta(game)
    metrics = metrics(game)
    filters = filters(game)

    %{id: id, meta: meta, metrics: metrics, filters: filters}
  end
end