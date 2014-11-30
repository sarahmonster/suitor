module PostingsHelper
  def cache_key_for_postings(method=:all, user=current_user)
    count = policy_scope(Posting.all).count +
            policy_scope(Interview.all).count +
            policy_scope(JobApplication.all).count +
            policy_scope(Offer.all).count

    max_updated_at = []
    max_updated_at << policy_scope(Posting.all).maximum(:updated_at).try(:utc).try(:to_i)
    max_updated_at << policy_scope(Interview.all).maximum(:updated_at).try(:utc).try(:to_i)
    max_updated_at << policy_scope(JobApplication.all).maximum(:updated_at).try(:utc).try(:to_i)
    max_updated_at << policy_scope(Offer.all).maximum(:updated_at).try(:utc).try(:to_i)

    max_updated_at = max_updated_at.reject(&:blank?).max

    "postings/for-user-#{user.id}/#{method}-#{count}-#{max_updated_at}"
  end
end
