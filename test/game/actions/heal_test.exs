defmodule ExMon.Game.Actions.HealTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player
  alias ExMon.Game
  alias ExMon.Game.Actions.Heal

  describe "heal_life/1" do

    setup do
      player = Player.build("Adriel", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when healling the player with life less 100 points" do
      message =
        capture_io(fn ->
          player_new_life =
            Game.info()
            |> Map.get(:player)
            |> Map.put(:life, 5)

          Game.info()
          |> Map.put(:player, player_new_life)
          |> Game.update()

          Heal.heal_life(:player)
        end)

      assert message =~ "The player healled itself"
    end

    test "when healling the player with life arround 100 points" do
      message =
        capture_io(fn ->
          player_new_life =
            Game.info()
            |> Map.get(:player)
            |> Map.put(:life, 90)

          Game.info()
          |> Map.put(:player, player_new_life)
          |> Game.update()

          Heal.heal_life(:player)
        end)

      assert message =~ "The player healled itself"
    end
  end
end
