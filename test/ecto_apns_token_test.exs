defmodule EctoApnsTokenTest do
  use ExUnit.Case
  doctest EctoApnsToken

  test "generate produces a 64 character string" do
    assert EctoApnsToken.generate() |> String.length() == 64
  end

  test "generated tokens validate to true" do
    assert EctoApnsToken.generate() |> EctoApnsToken.validate_apns_format()
  end

  test "validate fails on integers" do
    assert !EctoApnsToken.validate_apns_format(123)
  end

  test "validate accepts only strings of length 64" do
    refute 1..63
      |> Enum.map(fn _ -> "a" end)
      |> Enum.join("")
      |> EctoApnsToken.validate_apns_format()

    assert 1..64
      |> Enum.map(fn _ -> "a" end)
      |> Enum.join("")
      |> EctoApnsToken.validate_apns_format()

    refute 1..65
      |> Enum.map(fn _ -> "a" end)
      |> Enum.join("")
      |> EctoApnsToken.validate_apns_format()
  end

  test "validate accepts only strings with 0-9, a-f" do
    accepts_character = fn character ->
      1..64
      |> Enum.map(fn _ -> character end)
      |> Enum.join("")
      |> EctoApnsToken.validate_apns_format()
    end

    [
      "a", "b", "c", "d",
      "e", "f", "0", "1",
      "2", "3", "4", "5",
      "6", "7", "8", "9"
    ]
    |> Enum.map(accepts_character)
    |> Enum.map(&assert/1)

    [
      "g", "h", "i", "j",
      "k", "l", "m", "n",
      "o", "p", "q", "r",
      "s", "t", "u", "v",
      "w", "x", "y", "z"
    ]
    |> Enum.map(accepts_character)
    |> Enum.map(&refute/1)
  end

  test "EctoApnsToken underlying type is a string" do
    assert EctoApnsToken.type == :string
  end

  test "cast downcases" do
    given = 1..64 |> Enum.map(fn _ -> "A" end) |> Enum.join("")
    expected = 1..64 |> Enum.map(fn _ -> "a" end) |> Enum.join("")
    
    assert EctoApnsToken.cast(given) == {:ok, expected}
  end

  test "cast error on invalid" do
    assert EctoApnsToken.cast("willerror") == {:error, "'willerror' is not a valid APNS Token"}
  end

  test "load downcases" do
    given = 1..64 |> Enum.map(fn _ -> "A" end) |> Enum.join("")
    expected = 1..64 |> Enum.map(fn _ -> "a" end) |> Enum.join("")
    
    assert EctoApnsToken.load(given) == {:ok, expected}
  end

  test "load error on invalid" do
    assert EctoApnsToken.load("willerror") == {:error, "'willerror' is not a valid APNS Token"}
  end

  test "dump downcases" do
    given = 1..64 |> Enum.map(fn _ -> "A" end) |> Enum.join("")
    expected = 1..64 |> Enum.map(fn _ -> "a" end) |> Enum.join("")
    
    assert EctoApnsToken.dump(given) == {:ok, expected}
  end

  test "dump error on invalid" do
    assert EctoApnsToken.dump("willerror") == {:error, "'willerror' is not a valid APNS Token"}
  end
end
