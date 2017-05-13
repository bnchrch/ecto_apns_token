# EctoApnsToken

An Ecto type for storing, validating and generating Apple APNS Tokens

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ecto_apns_token` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ecto_apns_token, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ecto_apns_token](https://hexdocs.pm/ecto_apns_token).

## Usage
As a Ecto Model field type
```elixir
schema "devices" do
  field :id, EctoApnsToken, required: true
end
```

Generating a random 64 character APNS token
``` elixir
EctoApnsToken.generate()
"8108f10c539f54d9e07471adbe3910802b135970f81da7dec740f65396f8f468"
```