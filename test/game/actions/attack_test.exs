defmodule ExMon.Game.Actions.AttackTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player
  alias ExMon.Game
  alias ExMon.Game.Actions
  alias ExMon.Game.Actions.Attack

  describe "attack_opponent/2" do

    setup do
      player = Player.build("Adriel", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the player is attack the computer" do
      messages =
        capture_io(fn ->
          {_, player_attack} =
          Game.player()
          |> Map.get(:moves)
          |> Map.get(:move_avg)
          |> Actions.fetch_move()

          Attack.attack_opponent(:computer, player_attack)
        end)

      assert messages =~ "The Player attacked the computer"
    end

    test "when the player is attack the computer and life arround zero" do
      messages =
        capture_io(fn ->

          computer_new_life =
            Game.info()
            |> Map.get(:computer)
            |> Map.put(:life, 5)

          Game.info()
          |> Map.put(:computer, computer_new_life)
          |> Game.update()

          {_, player_attack} =
            Game.player()
            |> Map.get(:moves)
            |> Map.get(:move_avg)
            |> Actions.fetch_move()

          Attack.attack_opponent(:computer, player_attack)
        end)

      assert messages =~ "The Player attacked the computer"
    end
  end
end
