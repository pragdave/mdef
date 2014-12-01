defmodule MultiDefTest do
  use ExUnit.Case


  defmodule Test do

    import MultiDef

    mdef fred do
      { :init, val }   -> fred {:double, val}
      { :double, val } -> val*2
      a, b, c when a < b  -> a+b+c
    end

    mdefp wilma do
      { :init, val }   -> fred {:double, val}
      { :double, val } -> val*2
      a, b, c when a < b  -> a+b+c
    end

    def call_wilma(other), do: wilma(other)
    def call_wilma(a,b,c), do: wilma(a,b,c)
      
  end

  test "Single args" do
    assert Test.fred({:init, 3}) == 6
  end
  
  test "Multiple args" do
    assert Test.fred(4, 5, 6) == 15
  end

  test "When clauses" do
    assert_raise(
       FunctionClauseError,
       "no function clause matching in MultiDefTest.Test.fred/3",
        fn -> Test.fred(5,4,3) end)
  end

  test "private functions are private" do
    assert_raise(
       UndefinedFunctionError,
       "undefined function: MultiDefTest.Test.wilma/3",
        fn -> Test.wilma(5,4,3) end)
  end

  test "Private function is defined" do
    assert Test.call_wilma({:double, 2}) == 4
    assert Test.call_wilma(4, 5, 6) == 15
  end

  
end
