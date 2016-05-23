require_relative 'entry'

class AddressBook
  attr_reader :entries #all entries - list/index?

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)

    index = 0 #insertion index - prepend list?
    entries.each do |entry|
      if name < entry.name #we compare name with the name of the current entry, if name lexicographically proceeds entry.name, we've found the index to insert at, otherwise increment index and continue comparing with other entries
        break
      end
      index += 1
    end

    entries.insert(index, Entry.new(name, phone_number, email))
  end

  def remove_entry(name, phone_number, email)

    index = 0
    entries.each do |entry|
      if name == entry.name
        entries.delete(0)
      end
    end
  end
end
