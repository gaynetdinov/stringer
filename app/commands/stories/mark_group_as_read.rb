require_relative "../../repositories/story_repository"

class MarkGroupAsRead
  def initialize(group_id, timestamp, repository = StoryRepository)
    @group_id  = group_id.to_i
    @repo      = repository
    @timestamp = timestamp
  end

  def mark_group_as_read
    if @group_id && @group_id.to_i > 0
      @repo.fetch_unread_by_timestamp_and_group(@timestamp, @group_id).update_all(is_read: true)
    end
  end
end

