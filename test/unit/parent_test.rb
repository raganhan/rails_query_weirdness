  require 'test_helper'

class ParentTest < ActiveSupport::TestCase
  test "simple join" do
    parents_with_children = Parent.joins(:children)

    # duplicate parents because of the INNER JOIN :(
    assert_equal(2, parents_with_children.size)
  end

  test "with include" do
    parents_with_children = Parent.includes(:children).joins(:children)

    # the size here changes the query to a count duplicating the parents
    assert_equal(2, parents_with_children.size)
  end

  test "with include and all to force query" do
    parents_with_children = Parent.includes(:children).joins(:children).all

    # the extra info from the include helps rails remove the duplication
    # but you query more data than needed
    assert_equal(1, parents_with_children.size)
  end

  test "with group" do
    p = parents(:with_children)
    parents_with_children = Parent.joins(:children).group('parents.id')

    # the size here changes the query to a count duplicating the parents
    assert_equal({ p.id => 2 }, parents_with_children.size)
  end

  test "with group and all to force query" do
    parents_with_children = Parent.joins(:children).group('parents.id').all

    # works, my prefered way to deal with it
    assert_equal(1, parents_with_children.size)
  end
end
