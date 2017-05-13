defmodule EctoApnsToken do
  @moduledoc """
  An Ecto type for storing and validating Apple's APNS tokens.
  """

  @behaviour Ecto.Type

  # ======================= #
  # Ecto Specific Callbacks #
  # ======================= #

  @doc "Called when creating an Ecto.Changeset"
  @spec cast(any) :: Map.t
  def cast(value), do: apns_format(value)

  @doc "Converts/accepts a value that has been directly placed into the ecto struct after a changeset"
  @spec dump(any) :: Map.t
  def dump(value), do: apns_format(value)

  @doc "Converts a value from the database into the APNS Token type"
  @spec load(any) :: Map.t
  def load(value), do: apns_format(value)

  @doc "Callback invoked by autogenerate fields."
  @spec autogenerate() :: String.t  
  def autogenerate, do: generate()

  @doc "The Ecto type."
  def type, do: :string

  # ============ #
  # Custom Logic #
  # ============ #

  @doc "Format a given value to the APNS token"
  @spec apns_format(any) :: Map.t
  def apns_format(value) do
    case validate_apns_format(value) do
      true -> {:ok, String.downcase(value)}
      _ -> {:error, "'#{value}' is not a valid APNS Token"}
    end
  end

  @doc "Validate the given value as a string with 64 characters (64 characters a-f, A-F, 0-9)"
  def validate_apns_format(string) when is_binary(string), do: Regex.match?(~r/^[A-Fa-f0-9]{64}$/, string)
  def validate_apns_format(other), do: false

  @doc "Generates a random APNS token. (64 characters a-f, A-F, 0-9)"
  @spec generate() :: String.t
  def generate, do: :crypto.strong_rand_bytes(32) |> Base.encode16(case: :lower)
end
