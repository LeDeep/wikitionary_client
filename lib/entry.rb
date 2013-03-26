class Entry 

  attr_reader :word, :definition

  def initialize(attributes)
    @word = attributes[:word]
    @definition = attributes[:definition]
    @id = attributes[:id]
  end

  def save
    post_word = Faraday.post do |request|
      request.url 'http://wikitionarysmpjl.herokuapp.com/entries'  
      request.headers['Content-Type'] = 'application/json'
      request.body = {:entry => {:word => @word, :definition => @definition}}.to_json
    end
  end

  def self.view_word(id)
    response = Faraday.get "http://localhost:3000/entries/#{id}"
    entry = JSON.parse(response.body)
    words = entry['entry']
  end

  def self.all
    response = Faraday.get "http://localhost:3000/entries"
    entries_hash = JSON.parse(response.body, :symbolize_names => true)
    entries_hash.map { |entry| Entry.new(entry[:entry]) }
  end

  def self.edit_definition(id, user_input)
    edit_definition_response = Faraday.put do |request|
      request.url "http://wikitionarysmpjl.herokuapp.com/entries/#{id}"
      request.headers['Content-Type'] = 'application/json'
      request.body = {:entry => {:definition => "#{user_input}"}}.to_json
    end
  end

  def self.edit_word(id, user_input)
    edit_word_response = Faraday.put do |request|
      request.url "http://wikitionarysmpjl.herokuapp.com/entries/#{id}"
      request.headers['Content-Type'] = 'application/json'
      request.body = {:entry => {:word => "#{user_input}"}}.to_json
    end
  end

   def self.delete(id)
    delete_response = Faraday.delete do |request|
      request.url "http://wikitionarysmpjl.herokuapp.com/entries/#{id}"
      request.headers['Content-Type'] = 'application/json'
      request.body = {:entry => {:id => "#{id}"}}.to_json
    end
  end
end