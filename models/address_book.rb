require_relative 'entry'
require "csv"

class AddressBook
  attr_reader :entries #all entries - list/index?

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)

    index = 0 #start index for inserting single entry into array
    entries.each do |entry|
      if name < entry.name #we compare name with the name of the current entry, if name lexicographically proceeds entry.name, we've found the index to insert at, otherwise increment index and continue comparing with other entries
        break
      end
      index += 1
    end

    entries.insert(index, Entry.new(name, phone_number, email))
  end

  def remove_entry(name, phone_number, email)
    entries.delete_if do |entry|
      entry.name == name && entry.phone_number = phone_number && entry.email == email
    end
  end

  def nuke
    entries.delete_if { |entry| true } 
  end

  def import_from_csv(file_name)
    #reads file
    csv_text = File.read(file_name)
    #parse csv formatted file using the CSV class
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)

    #iterate over CSV::Table object's rows, then create hash for each row, then convert each row_hash to an Entry using add_entry
    csv.each do |row|
      #converts each to row to a hash - associative array
      row_hash = row.to_hash
      #assign value to be passed to method based on hash value
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end

  #searches AddressBook for a specific entry by name


  def iterative_search(name)
    @entries.each do |entry|
      if name == entry.name
        return entry.name
      end
    end
    return nil
  end
end
