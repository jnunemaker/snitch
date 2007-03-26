module Tinder
  class Campfire
    def find_or_create_room_by_name(name)
      room = find_room_by_name(name)
      room = create_room(name) if room.nil?
      room
    end
  end
end