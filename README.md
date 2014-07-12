MultiDef—Define a function with multiple heads
==============================================

Add the dependency `{:multidef, "> 0.0.0"}` to mix.exs.

Use it like this:

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

Does not support default arguments.

Does not enforce that all heads have the same arity (deliberately).


----

Copyright © 2014 Dave Thomas, The Pragmatic Programmers
@/+pragdave, dave@pragprog.com

Licensed under the same terms as Elixir
