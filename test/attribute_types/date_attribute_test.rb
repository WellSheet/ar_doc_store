require_relative './../test_helper'

class DateAttributeTest < MiniTest::Test

  def test_attribute_on_model_init
    approved_date = Date.new(1984, 3, 6)
    po = PurchaseOrder.new approved_date: approved_date
    assert approved_date == po.approved_date
  end

  def test_attribute_on_existing_model
    approved_date = Date.new(1984, 3, 6)
    po = PurchaseOrder.new
    po.approved_date = approved_date
    assert approved_date == po.approved_date
    assert po.approved_date_changed?
  end

  def test_conversion
    approved_date = Date.new(1984, 3, 6)
    po = PurchaseOrder.new approved_date: approved_date.to_s
    assert_kind_of Date, po.approved_date
  end

  def test_no_op
    po = PurchaseOrder.new
    assert_nil po.approved_date
  end
end
