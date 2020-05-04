require "../spec_helper"

describe "directory_util_scan" do
  describe "when directory root is not a directory" do
    it "should raise exception" do
      expect_raises(Exception, "argument is not a directory") do
        scan "fixtures/abc"
      end
    end
  end

  describe "when directory root entries is not empty" do
    it "should return array valid entries file path and size" do
      expected_result = {"fixtures/sample/helloworld.cr" => 18, "fixtures/sample/helper/readme" => 4}

      result = scan "fixtures/sample"

      result.size.should eq 2
    end
  end

  describe "when directory root entries is not empty and file size empty" do
    it "should skip collecting those empty size files" do
      result = scan "fixtures/emptyfile"

      result.empty?.should be_true
    end
  end
end
