require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new #instantiating address_book
  end

  def main_menu
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - View entry by position" #added menu selection
    puts "3 - Create an entry"
    puts "4 - Search for an entry"
    puts "5 - Import entries from a CSV"
    puts "6 - Exit"
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
        view_entry_n #added method
        main_menu
      when 3
        system "clear"
        create_entry
        main_menu
      when 4
        system "clear"
        search_entries
        main_menu
      when 5
        system "clear"
        read_csv
        main_menu
      when 6
        puts "Good-bye!"
        exit(0) #0 signals the program is exiting withot error

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

  def view_entry_n
    entry_count = address_book.entries.count
    if entry_count > 0
      system "clear"
      puts "Pick an entry position between 1 and #{entry_count}"
      n = gets.chomp.to_i - 1
      address_book.entries.each_with_index do |entry, index|
        if index == n
          system "clear"
          puts entry.to_s
          main_menu
        else
          puts "invalid selection"
          main_menu
        end
      end
    else
      puts "There are no entries"
    end
  end

  def create_entry
    system "clear"
    puts "New AddressBloc Entry"

    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print = "Email: " #not printing
    email = gets.chomp

    address_book.add_entry(name, phone, email)

    system "clear"
    puts "new entry created"

  end

  def search_entries

  end

  def read_csv
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
      when "e"

      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selction} is not a valid input"
        entry_submenu(entry)
    end
  end
end
