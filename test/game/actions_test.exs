defmodule ExMon.Game.ActionsTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player
  alias ExMon.Game
  alias ExMon.Game.Actions

  describe "attack/1" do

    setup do
      player = Player.build("Adriel", :chute, :soco, :cura)
      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when player attack the computer" do

      message =
        capture_io(fn ->
          {_, player_attack} =
            Game.player()
            |> Map.get(:moves)
            |> Map.get(:move_avg)
            |> Actions.fetch_move()

          Actions.attack(player_attack)
        end)

      assert message =~ "The Player attacked the computer dealing"
    end
  end
  describe "heal/0" do

    setup do
      player = Player.build("Adriel", :chute, :soco, :cura)
      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when player healself " do
      message =
        capture_io(fn ->
          Actions.heal()
        end)

      assert message =~ "The player healled itself to"
    end

    test "when computer healself " do

      message =
        capture_io(fn ->
          Game.info()
          |> Map.put(:turn, :computer)
          |> Game.update()

          Actions.heal()
        end)

      assert message =~ "The player healled itself to"
    end
  end

  describe "fetch_move/1" do

    setup do
      player = Player.build("Adriel", :chute, :soco, :cura)
      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when find move to player" do

      {_, expected_response} = Actions.fetch_move(:chute)

      assert expected_response == :move_rnd
    end
  end
end
