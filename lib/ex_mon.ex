defmodule ExMon do
  alias ExMon.{Game,Player}
  alias ExMon.Game.{Actions, Status}

  @computer_name "Robotinik"
  @computer_moves [:move_avg, :move_rnd, :move_heal]
  @raffle_players [:computer, :player]

  def create_player(name, move_avg, move_rnd, move_heal) do
    Player.build(name, move_avg, move_rnd, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> raffle_players_starts(player)
  end

  defp raffle_players_starts(computer, player) do
    @raffle_players
    |> Enum.random
    |> Game.start(computer, player)

    Status.print_round_message(Game.info())
    computer_start()
  end

  defp computer_start() do
    Game.info()
    |> computer_choice
  end

  defp computer_choice(%{turn: :computer, status: :started}), do: computer_move(Game.info())
  defp computer_choice(_), do: :ok

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())
  defp handle_status(_other, move) do
    move
    |> Actions.fetch_move()
    |> do_move()

    computer_move(Game.info())
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)
  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  defp computer_move(%{computer: %Player{life: computer_life}}) when computer_life < 40 do
    {:ok, Enum.random(@computer_moves ++ [:move_heal, :move_heal])}
    |> do_move()
  end

  defp computer_move(%{turn: :computer, status: :started}) do
    {:ok, Enum.random(@computer_moves)}
    |> do_move
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    {:ok, Enum.random(@computer_moves)}
    |> do_move
  end

  defp computer_move(_), do: :ok
end
