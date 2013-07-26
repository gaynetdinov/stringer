require_relative "../models/group"

class GroupRepository

  def self.list
    Group.order('lower(name)')
  end

end
