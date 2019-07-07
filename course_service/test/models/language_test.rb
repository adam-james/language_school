require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test "validates name" do
    language = languages(:one)
    language.name = nil
    assert language.valid? == false
  end
end
