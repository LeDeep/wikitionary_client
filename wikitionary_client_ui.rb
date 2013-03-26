require 'faraday'
require 'json'

require './lib/entry'

def welcome
  puts "Welcome to the Epicodus Wikitionary."
  menu
end

def menu
  choice = nil
  until choice == 'x'
    puts "What would you like to do?"
    puts "Press 'c' to create a new word, 'r' to view words(do not press r), 'u' to update a word , 'd' to delete a word."
    puts "Press 'x' to exit."

    case choice = gets.chomp
    when 'c'
      create
    when 'r'
      view
    when 'u'
      update
    when 'd'
      delete
    when 'x'
      exit
    else
      invalid
    end
  end
end

def create
  word = nil
  definition = nil
  while word.nil?
    puts "What word would you like to add to the Wikitionary?"
    word = gets.chomp
    puts "What is the definition you would like to add for this word?"
    definition = gets.chomp
    new_word = Entry.new({:word => word, :definition => definition})
    new_word.save 
  end    
  puts "Your new word and definition have been added to the Wikitionary!"
end

def view
  results = Entry.all
  results.map {|word| puts "\n" + word }
end

def delete
  puts "What is the id of the word you want to delete?"
  id = gets.chomp
  Entry.delete(id)
  puts "Wikitionary word with #{id}, has been deleted."
end

def update
  choice = nil
  puts "What is the word id you would like to edit?"
  id = gets.chomp
  puts "What would you like to edit? Press 1 to edit the word or 2 to edit definition"
  case choice = gets.chomp
  when '1'
    puts "Please enter the updated word:"
    word_name = gets.chomp
    Entry.edit_word(id, word_name)
  when '2'
    puts "Please enter the updated definition:"
    definition = gets.chomp
    Entry.edit_definition(id, definition)
  else
    menu
  end
end


welcome