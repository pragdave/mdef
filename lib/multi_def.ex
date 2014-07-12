defmodule MultiDef do

  @doc """
  Define a function with multiple heads. Use it like this:

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
  """
  defmacro mdef({name, _line, nil}, [do: clauses]) do
    for {:->, _line, [args, body]} <- clauses do
      quote do
        def unquote(name)(unquote_splicing(args)) do
          unquote(body)
        end
      end
    end
  end

end
