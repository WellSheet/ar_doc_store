require_relative './../test_helper'

class EncryptedStringAttributeTest < MiniTest::Test

  def test_attribute_on_model_init
    b = Building.new code: 'test'
    assert_equal 'test', b.code
  end

  def test_attribute_on_existing_model
    b = Building.new
    b.code = 'test'
    assert_equal 'test', b.code
    assert b.code_changed?
  end

  def test_question_mark_method
    b = Building.new code: 'test'
    assert_equal true, b.code?
  end

  def test_conversion
    b = Building.new code: 51
    assert_equal '51', b.code
  end
end
