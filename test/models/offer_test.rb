require 'test_helper'

class OfferTest < ActiveSupport::TestCase
  test "only one Offer per Posting" do
    posting = postings(:unique_tester)
    posting.save

    offer = Offer.new({posting: posting})
    assert offer.save, "First Offer should be saved"

    repeat_offer = Offer.new({posting: posting})
    assert_not repeat_offer.save, "Second Offer should not be saved"
  end
end
