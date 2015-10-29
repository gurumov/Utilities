require_relative "FilesUtils"
require "test/unit"

class TestFilesUtils < Test::Unit::TestCase

  def test_valid_path
    path = "C:\\"
    assert_instance_of FilesUtils, FilesUtils.new(path), "FFF"
  end

  def test_invalid_path
    path = "C:\Users"
    assert_raise (Errno::ENOENT) { FilesUtils.new(path) }
  end

  def test_empty_path
    path = ""
    assert_raise (ArgumentError) { FilesUtils.new(path) }
  end

end
