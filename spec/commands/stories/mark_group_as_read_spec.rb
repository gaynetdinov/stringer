require "spec_helper"

app_require "commands/stories/mark_group_as_read"

describe MarkGroupAsRead do
  describe "#mark_group_as_read" do
    let(:stories) { stub }
    let(:repo){ stub }
    let(:timestamp) { Time.now.to_i }

    it "marks passed group as read" do
      command = MarkGroupAsRead.new(15, timestamp, repo)
      stories.should_receive(:update_all).with(is_read: true)
      repo.should_receive(:fetch_unread_by_timestamp_and_group).with(timestamp, 15).and_return(stories)
      command.mark_group_as_read
    end

    it "does not mark any group as read when group isn't provided" do
      command = MarkGroupAsRead.new(nil, Time.now.to_i, repo)
      repo.should_not_receive(:fetch_unread_by_timestamp_and_group)
      command.mark_group_as_read
    end

    it "does not mark any group as read when group is 0" do
      command = MarkGroupAsRead.new(0, Time.now.to_i, repo)
      repo.should_not_receive(:fetch_unread_by_timestamp_and_group)
      command.mark_group_as_read
    end
  end
end
