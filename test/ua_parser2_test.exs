defmodule UAParser2Test do
  use ExUnit.Case

  test "parses user agent string" do
    parsed = UAParser2.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:47.0) Gecko/20100101 Firefox/47.0")

    assert parsed = %UAParser2.Result{
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
  end
end
