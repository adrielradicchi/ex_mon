defmodule ExMon.Game.Actions do
  alias ExMon.Game
  alias ExMon.Game.Actions.{Attack, Heal}

  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_opponent(:computer, move)
      :computer -> Attack.attack_opponent(:player, move)
    end
  end

  def fetch_move(move) do
    Game.player()
    |> Map.get(:moves)
    |> find_move(move)
  end

  def find_move(moves, move) do
    Enum.find_value(moves, {:error}, fn {key, value} ->
      if value == move, do: {:ok, key}
    end)
    #   Enum.find_value(moves, {:error}, &search_move/2 )
  end

  # def search_move({key, value}, move) when value == move do: {:ok,}

  def heal() do
    case Game.turn() do
      :player -> Heal.heal_life(:player)
      :computer -> Heal.heal_life(:computer)
    end
  end

end
