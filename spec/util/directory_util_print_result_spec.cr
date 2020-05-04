require "../spec_helper"

describe "directory_util_print_result" do
  describe "when array is not empty and computer_mode is false" do
    it "should return array of printed lines" do
      arr = [{"xyz", 99.to_i64}, {"abc", 3.to_i64}]
      expected_result = ["\e[32m  99.0\e[0m xyz", "\e[32m   3.0\e[0m abc"]
      computer_mode = false

      result = print_result(arr, computer_mode)

      result.size.should eq 2
      result.should eq expected_result
    end
  end

  describe "when array is not empty and computer_mode is true" do
    it "should return array of printed lines" do
      arr = [{"xyz", 99.to_i64}, {"abc", 3.to_i64}]
      expected_result = ["99 xyz", " 3 abc"]
      computer_mode = true

      result = print_result(arr, computer_mode)

      result.size.should eq 2
      result.should eq expected_result
    end
  end

  describe "when array is empty" do
    it "should return empty array of string" do
      arr = [] of Tuple(String, Int64)
      computer_mode = true

      result = print_result(arr, computer_mode)

      result.empty?.should be_true
    end
  end
end
