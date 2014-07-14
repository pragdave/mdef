MultiDef—Define a function with multiple heads
==============================================

Add the dependency `{:multidef, "> 0.0.0"}` to mix.exs.

Use it like this:

      defmodule Test do

        import MultiDef

        mdef fib do
          0 -> 0
          1 -> 1
          n -> fib(n-1) + fib(n-1)
        end
      end

      IO.puts Test.fib(20)

When clauses can be used:

      defmodule Test do

        import MultiDef

        mdef fib do
          0 -> 0
          1 -> 1
          n when n > 0 -> fib(n-1) + fib(n-1)
        end
      end

      IO.puts Test.fib(20)

Does not support default arguments.

Does not enforce that all heads have the same arity (deliberately).

----

Copyright © 2014 Dave Thomas, The Pragmatic Programmers  
@/+pragdave, dave@pragprog.com

Licensed under the same terms as Elixir
