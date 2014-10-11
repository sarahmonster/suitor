require 'test_helper'

class PostingTest < ActiveSupport::TestCase
  test "posting needs a title, company, and user" do
    posting = Posting.new
    assert_not posting.save, "Saved posting without a title and company"

    posting = Posting.new(title: "Y2K Analyst")
    assert_not posting.save, "Saved posting without a company"

    posting = Posting.new(hiring_organization: "Initech")
    assert_not posting.save, "Saved posting without a title"

    posting = Posting.new(title: "Y2K Analyst", hiring_organization: "Initech")
    assert_not posting.save, "Saved posting without a user"

    posting = Posting.new(title: "Y2K Analyst", hiring_organization: "Initech",
                          user: users(:one))
    assert posting.save, "Posting should save with all required properties"
  end
end
