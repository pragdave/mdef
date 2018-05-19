defmodule MultiDefTest do
  use ExUnit.Case

  import MultiDef

  mdef fred do
    {:init, val} -> fred({:double, val})
    {:double, val} -> val * 2
    a, b, c when a < b -> a + b + c
  end

  mdefp fredp do
    {:init, val} -> fredp({:double, val})
    {:double, val} -> val * 2
    a, b, c when a < b -> a + b + c
  end

  test "Single args public" do
    assert fred({:init, 3}) == 6
  end

  test "Single args private" do
    assert fredp({:init, 3}) == 6
  end

  test "Multiple args public" do
    assert fred(4, 5, 6) == 15
  end

  test "Multiple args private" do
    assert fredp(4, 5, 6) == 15
  end

  test "When clauses public" do
    assert_raise(
      FunctionClauseError,
      "no function clause matching in MultiDefTest.fred/3",
      fn -> fred(5, 4, 3) end
    )
  end

  test "When clauses private" do
    assert_raise(
      FunctionClauseError,
      "no function clause matching in MultiDefTest.fredp/3",
      fn -> fredp(5, 4, 3) end
    )
  end
end
