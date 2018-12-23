defmodule ChronalCalibrationTest do
  use ExUnit.Case, async: true

  describe "final_frequency/1" do
    test "returns the final frequency for a given input" do
      input = "priv/input.txt"

      assert ChronalCalibration.final_frequency(input) == 531
    end
  end

  describe "repeated_frequency/1" do
    test "returns the first repeated frequency for a given input" do
      input = "priv/input.txt"

      assert ChronalCalibration.repeated_frequency(input) == 76787
    end
  end
end
