  require 'test_helper'

class ParentTest < ActiveSupport::TestCase
  test "simple join" do
    parents_with_children = Parent.joins(:children)

    assert_equal(1, parents_with_children.size)
  end

  test "with include" do
    parents_with_children = Parent.includes(:children).joins(:children)

    assert_equal(1, parents_with_children.size)
  end

  test "with include and all to force query" do
    parents_with_children = Parent.includes(:children).joins(:children).all

    assert_equal(1, parents_with_children.size)
  end

  test "with group" do
    parents_with_children = Parent.joins(:children).group('parents.id')

    assert_equal(1, parents_with_children.size)
  end

  test "with group and all to force query" do
    parents_with_children = Parent.joins(:children).group('parents.id').all

    assert_equal(1, parents_with_children.size)
  end
end
