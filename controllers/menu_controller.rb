require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new #instantiating address_book
  end

  def main_menu
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    puts "6 - Nuke everything!"
    print "Enter your selection: "

    selection = gets.to_i
    puts "You picked #{selection}"

    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        puts "Good-bye!"
        exit(0) #0 signals the program is exiting withot error
      when 6
        system "clear"
        address_book.nuke_entries
        puts "You just deleted EVERYTHING!!!"
        main_menu

      else #catches invalid input
        system "clear"
        puts "Sorry, that is not a valid input"
        main_menu
    end
  end

  def view_all_entries
    address_book.entries.each do |entry| #getting this object from AddressBook - why not an instance variable here?
      system "clear"
      puts entry.to_s

      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def create_entry
    system "clear"
    puts "New AddressBloc Entry"

    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: " #not printing
    email = gets.chomp

    address_book.add_entry(name, phone, email)

    system "clear"
    puts "new entry created"

  end

  def search_entries

    #get user name to search
    print "Search by name: "
    name = gets.chomp

    #search address_book which returns match or nil
    match = address_book.binary_search(name)
    system "clear"

    #if search returned match - call helper method to display list of operations that can be performed on Entry
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end

  end

  def read_csv

    print "Enter CSV file to import: "
    file_name = gets.chomp
      if file_name.empty?
        system "clear"
        puts "No CSV file read"
        main_menu
      end

      begin
        entry_count = address_book.import_from_csv(file_name).count
        system "clear"
        puts "#{entry_count} new entries added from #{file_name}"
      rescue
        puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
        read_csv
      end
  end

  def entry_submenu(entry)
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    selection = gets.chomp #chomp removes trailing white space - "m " or "m\n" won't match "m"

    case selection

      when "n"

      when "d"

        delete_entry(entry)
      when "e"

        edit_entry(entry)
        entry_submenu(entry)

      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selction} is not a valid input"
        entry_submenu(entry)
    end
  end

  def edit_entry(entry)
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp

    #!attribute.empty? - set only if valid attribute read from user input
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"

    puts "Updated entry:"
    puts entry
  end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def nuke
    address_book.entries.each do |entry|
      entry.delete #deletes everything but Bob and Sally
    end
  end

  def edit_entry(entry)

    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp

    #!attribute.empty? - set only if valid attribute read from user input
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"

    puts "Updated entry:"
    puts entry
  end

  def search_submenu(entry)
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main_menu"

    selection = gets.chomp

    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
    end
  end
end
