defmodule ExMon.Games.StatusTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.{Game,Player}
  alias ExMon.Game.Status

  describe "print_round_message/1" do

    setup do
      capture_io(fn ->
        player = Player.build("Adriel", :chute, :soco, :cura)

          "Robotinik"
          |> ExMon.create_player(:punch, :kick, :heal)
          |> Game.start(player)
      end)

      :ok
    end

    test "when game is started" do
      message =
        capture_io(fn ->
          Game.info()
          |> Status.print_round_message()
        end)

      assert message =~ "The game is started!"
    end

    test "when game is continue" do
      message =
        capture_io(fn ->
          Game.info()
          |> Map.put(:status, :continue)
          |> Game.update()

          Game.info()
          |> Status.print_round_message()

        end)

      assert message =~ "It's computer turn."
    end

    test "when game is over" do
      message =
        capture_io(fn ->
          Game.info()
          |> Map.put(:status, :game_over)
          |> Status.print_round_message()

        end)

      assert message =~ "The game is over!"
    end
  end

  describe "print_move_message/1" do

    setup do
      capture_io(fn ->
        player = Player.build("Adriel", :chute, :soco, :cura)

        "Robotinik"
        |> ExMon.create_player(:punch, :kick, :heal)
        |> Game.start(player)
      end)
      :ok
    end

    test "when player attack computer" do
      message =
        capture_io(fn ->
          Game.info()
          |> Map.get(:turn)
          |> Status.print_move_message(:attack, 50)
        end)

      assert message =~ "The Computer attacked the player dealing"
    end

    test "when computer attack player" do
      message =
        capture_io(fn ->
          Game.info()
          |> Map.put(:turn, :computer)
          |> Map.get(:turn)
          |> Status.print_move_message(:attack, 50)
        end)

      assert message =~ "The Player attacked the computer dealing"
    end

    test "when player recovere life" do
      message =
        capture_io(fn ->
          Game.info()
          |> Map.get(:turn)
          |> Status.print_move_message(:heal, 50)
        end)

      assert message =~ "The player healled itself to"
    end

    test "when computer recovere life" do
      message =
        capture_io(fn ->
          Game.info()
          |> Map.put(:turn, :computer)
          |> Map.get(:turn)
          |> Status.print_move_message(:heal, 50)
        end)

      assert message =~ "The computer healled itself to"
    end
  end

  describe "print_wrong_move_message/1" do

    setup do

      capture_io(fn ->
        player = Player.build("Adriel", :chute, :soco, :cura)

        "Robotinik"
        |> ExMon.create_player(:punch, :kick, :heal)
        |> Game.start(player)
      end)

      :ok
    end

    test "when worng move played" do
      message =
        capture_io(fn ->
          Status.print_wrong_move_message(:move_rtx)
        end)

      assert message =~ "Invalid move"
    end
  end
end
