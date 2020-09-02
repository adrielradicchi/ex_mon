defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/3" do
    test "start the game with player state" do
      player = Player.build("Adriel", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(:player, computer, player)
    end

    test "start the game with computer state" do
      player = Player.build("Adriel", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(:computer, computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state with player started" do
      player = Player.build("Adriel", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(:player, computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Adriel"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end

    test "returns the current game state with computer started" do
      player = Player.build("Adriel", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(:computer, computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Adriel"
        },
        status: :started,
        turn: :computer
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the current player started game update" do
      player = Player.build("Adriel", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(:player, computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Adriel"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Robotinik"
        },
        player: %Player{
          life: 50,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Adriel"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end

    test "returns the current computer started game update" do
      player = Player.build("Adriel", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(:computer, computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Adriel"
        },
        status: :started,
        turn: :computer
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Robotinik"
        },
        player: %Player{
          life: 50,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Adriel"
        },
        status: :started,
        turn: :computer
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :player, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns the player with player started" do
      player = Player.build("Adriel", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(:player, computer, player)

      expected_response =
        %Player{
          life: 100,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Adriel"
        }

      assert expected_response == Game.player()
    end

    test "returns the player with computer started" do
      player = Player.build("Adriel", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(:computer, computer, player)

      expected_response =
        %Player{
          life: 100,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Adriel"
        }

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "returns the current turn with player started" do
      player = Player.build("Adriel", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(:player, computer, player)

      assert :player == Game.turn()
    end

    test "returns the current turn with computer started" do
      player = Player.build("Adriel", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(:computer, computer, player)

      assert :computer == Game.turn()
    end
  end

  describe "fetch_player/1" do
    test "returns the player with started player" do
      player = Player.build("Adriel", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(:player, computer, player)

      assert player == Game.fetch_player(:player)
    end

    test "returns the player with started computer" do
      player = Player.build("Adriel", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(:computer, computer, player)

      assert computer == Game.fetch_player(:computer)
    end
  end
end
