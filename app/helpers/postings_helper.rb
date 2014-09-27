module PostingsHelper
  def cache_key_for_postings(method=:all, user=current_user)
    count = policy_scope(Posting.all).count
    max_updated_at = policy_scope(Posting.all).maximum(:updated_at).try(:utc).try(:to_s, :number)
    "postings/for-user-#{user.id}/#{method}-#{count}-#{max_updated_at}"
  end
end
