defmodule PhoenixReactPlayground.Redix do
  @moduledoc false

  # Client API

  def put(redix, key, value) do
    command = ["SET", key, encode(value)]

    case Redix.command(redix, command) do
      {:ok, _} -> :ok
      _ -> {:error, "Can not execute '#{commands_to_string(command)}'"}
    end
  end

  def get(redix, key) do
    command = ["GET", key]

    case Redix.command(redix, command) do
      {:ok, nil} -> {:error, :not_found}
      {:ok, res} -> {:ok, decode(res)}
      error -> {:error, {error, "Error execute..."}}
    end
  end

  defmacro __using__(opts) do
    redix = assert_valid_key(opts[:redix])

    quote do
      @behaviour TextGen.Behaviour.PersistStorage

      @impl true
      def put(key, value), do: unquote(__MODULE__).put(unquote(redix), key, value)

      @impl true
      def get(key), do: unquote(__MODULE__).get(unquote(redix), key)
    end
  end

  # Helpers

  defp commands_to_string(commands) do
    commands
    |> List.flatten()
    |> Enum.join(" ")
  end

  defp assert_valid_key(nil) do
    raise CompileError, description: "You should specify redix option when use #{__MODULE__}"
  end

  defp assert_valid_key(app), do: app

  defp encode(value), do: :erlang.term_to_binary(value)
  defp decode(value), do: :erlang.binary_to_term(value)
end
