class Entry 

  attr_reader :word, :definition

  def initialize(attributes)
    @word = attributes[:word]
    @definition = attributes[:definition]
    @id = attributes[:id]
  end

  def save
    post_word = Faraday.post do |request|
      request.url 'http://localhost:3000/entries'  
      request.headers['Content-Type'] = 'application/json'
      request.body = {:entry => {:word => @word, :definition => @definition}}.to_json
    end
  end

  # def self.view_word(id)
  #   response = Faraday.get "http://localhost:3000/entries/#{id}"
  #   entry = JSON.parse(response.body)
  #   words = entry['entry']
  #   #UI>>>>>>>> words['word'] + ": " + words['definition']
  # end

  # def self.all
  #   response = Faraday.get "http://localhost:3000/entries"
  #   entries_hash = JSON.parse(response.body)
    
  #   #entry_object = entries_hash.each { |entry| entry[] }
  #   foo = entries_hash.map do |entry|
  #     # binding.pry 
  #     Entry.new(entry.each {|entry| entry['entry']})
  #   end
  
  #   #UI >>>>> words.map {|word| (word['word'] + ": " + word['definition'])}
  # end

  def self.edit_definition(id, user_input)
    edit_definition_response = Faraday.put do |request|
      request.url "http://localhost:3000/entries/#{id}"
      request.headers['Content-Type'] = 'application/json'
      request.body = {:entry => {:definition => "#{user_input}"}}.to_json
    end
  end

  def self.edit_word(id, user_input)
    edit_word_response = Faraday.put do |request|
      request.url "http://localhost:3000/entries/#{id}"
      request.headers['Content-Type'] = 'application/json'
      request.body = {:entry => {:word => "#{user_input}"}}.to_json
    end
  end

   def self.delete(id)
    delete_response = Faraday.delete do |request|
      request.url "http://localhost:3000/entries/#{id}"
      request.headers['Content-Type'] = 'application/json'
      request.body = {:entry => {:id => "#{id}"}}.to_json
    end
  end


end