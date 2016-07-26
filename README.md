# Echo-Elixir-Server [![Build Status](https://travis-ci.org/areski/echo-server-elixir.svg?branch=master)](https://travis-ci.org/areski/echo-server-elixir)

> Simple Echo Elixir Server

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add echo to your list of dependencies in `mix.exs`:

        def deps do
          [{:echo, "~> 0.0.1"}]
        end

  2. Ensure echo is started before your application:

        def application do
          [applications: [:echo]]
        end


## Prepare release

Compile and prepare release:

  MIX_ENV=prod mix compile

  MIX_ENV=prod mix release


## To Do

- [ ] Nada
