defmodule MultiDefTest do
  use ExUnit.Case

  defmodule Test do

    import MultiDef

    mdef fred do
      { :init, val }   -> fred {:double, val}
      { :double, val } -> val * 2
      a, b, c when a < b  -> a + b + c
    end

    def dispatch_to_private(arg) do
      private(arg)
    end

    mdefp private do
      {:add, list} when is_list(list) -> :lists.sum list
      {:mul, list} -> Enum.reduce(list, &Kernel.*/2)
    end
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
       fn -> Test.fred(5, 4, 3) end)
  end

  test "Private function, directly called" do
    assert_raise(
      UndefinedFunctionError,
      "undefined function: MultiDefTest.Test.private/1",
      fn -> Test.private(:anything) end)
  end

  test "Private addition function, indirectly called" do
    assert Test.dispatch_to_private({:add, [1, 2, 3]}) == 6
  end

  test "Private multiplication function, indirectly called" do
    assert Test.dispatch_to_private({:mul, [2, 2, 2]}) == 8
  end

  test "Private function, missing clause" do
    assert_raise(
      FunctionClauseError,
      "no function clause matching in MultiDefTest.Test.private/1",
      fn -> Test.dispatch_to_private({:add, :not_a_list}) end)
  end
end
