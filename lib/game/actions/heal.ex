defmodule ExMon.Game.Actions.Heal do

  alias ExMon.Game

  def heal_life(player) do
    player
    |> Game.fecth_player()
  end
end
