# UAParser2

[![Build Status](https://travis-ci.org/nazipov/ua_parser2-elixir.svg?branch=master)](https://travis-ci.org/nazipov/ua_parser2-elixir)
[![Hex pm](https://img.shields.io/hexpm/v/ua_parser2.svg?style=flat)](https://hex.pm/packages/ua_parser2)

A port of [ua-parser2](https://www.npmjs.com/package/ua-parser2) to Elixir

# Installation

Add UAParser2 as a dependency to your project's `mix.exs`:

```elixir
def application do
  [applications: [:ua_parser2]]
end

defp deps do
  [{:ua_parser2, github: "nazipov/ua_parser2-elixir"}]
end
```

and then run `$ mix deps.get`

# Usage

```elixir
iex(1)> UAParser2.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:47.0) Gecko/20100101 Firefox/47.0")
%UAParser2.Result{
  string: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:47.0) Gecko/20100101 Firefox/47.0",
  device: nil,
  engine: %UAParser2.Result.Engine{
    family: "Gecko", 
    major: "47", 
    minor: "0",
    patch: nil, 
    type: nil
  },
  os: %UAParser2.Result.OS{
    family: "Mac OS X", 
    major: "10", 
    minor: "11",
    patch: nil, 
    patchMinor: nil, 
    type: nil
  },
  ua: %UAParser2.Result.UA{
    family: "Firefox", 
    major: "47", 
    minor: "0", 
    patch: nil, 
    type: nil
  }
}
```

# License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)

The parser databases are taken from the [commenthol/ua-parser2](https://github.com/commenthol/ua-parser2) project. See there for detailed license information about the data contained.