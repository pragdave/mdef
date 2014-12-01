defmodule Mdef.Mixfile do
  use Mix.Project

  def project do
    [
     app:         :multidef,
     version:     "0.3.0",
     elixir:      ">= 1.0.0",
     deps:        [],
     description: description,
     package:     package,
    ]
  end

  def application do
    [applications: []]
  end

  defp description do
    """
    Lets you define multiple heads for the same function:

        defmodule Test do

          import MultiDef

          mdef fred do
            { :init, val }   -> fred {:double, val}
            { :double, val } -> IO.puts(val*2)
            a, b             -> a+b
          end
        end

        IO.inspect Test.fred 1, 2          #=> 3
        IO.inspect Test.fred { :init, 4 }  #=> 8

    """
  end

  defp package do
    [
      files:        [ "lib", "priv", "mix.exs", "README.md" ],
      contributors: [ "Dave Thomas <dave@pragprog.org>"],
      licenses:     [ "Same as Elixir" ],
      links:        %{
                       "GitHub" => "https://github.com/pragdave/mdef",
                    }
    ]
  end


end
