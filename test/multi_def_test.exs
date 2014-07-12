defmodule MultiDefTest do
  use ExUnit.Case


  defmodule Test do

    import MultiDef

    mdef fred do
      { :init, val }   -> fred {:double, val}
      { :double, val } -> val*2
      a, b             -> a+b
    end
  end

  test "Single args" do
    assert Test.fred({:init, 3}) == 6
  end

  test "Multiple args" do
    assert Test.fred(4, 5) == 9
  end

end
