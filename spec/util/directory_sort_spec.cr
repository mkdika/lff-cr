require "../spec_helper"

describe "directory_util_sort" do
  describe "when map is not empty" do
    it "should sort and return tuple as file_limit" do
      map = {"abc" => 3.to_i64, "bcd" => 1.to_i64, "xyz" => 9.to_i64}
      file_limit = 2
      expected_arr = [{"xyz",9}, {"abc", 3}]

      result = sort(map, file_limit)

      result.size.should eq 2
      result.should eq expected_arr
    end
  end

  describe "when map is empty" do
    it "should return empty array" do
      map = {} of String => Int64
      file_limit = 2

      result = sort map, file_limit

      result.empty?.should be_true
    end
  end

  describe "when file_limit is below 1" do
    it "should return empty array" do
      map = {"abc" => 3.to_i64, "bcd" => 1.to_i64, "xyz" => 99.to_i64}
      file_limit = 0

      result = sort map, file_limit

      result.empty?.should be_true
    end
  end
end