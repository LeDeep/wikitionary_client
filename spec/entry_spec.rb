require 'spec_helper'

describe Entry do

   # let(:init_stub) {stub_request(:post, "https://#{api.twitter.com/oauth/request_token}").
  #   to_return(:body => "oauth_token=t&oauth_token_secret=s")} #word and definition
   
  # let(:access_stub) {stub_request(:post, "https://api.twitter.com/oauth/access_token").
  #   to_return(:body => "oauth_token=at&oauth_token_secret=as&screen_name=sn")}


  # let(:settings_stub)   {stub_request(:get, 'https://api.twitter.com/1.1/account/settings.json').
  #                     to_return(:body => "{\"protected\":false,\"screen_name\":\"LeDeep7\",\"always_use_https\":true,\"language\":\"en\",\"trend_location\":[{\"url\":\"http:\\/\\/where.yahooapis.com\\/v1\\/place\\/1\",\"name\":\"Worldwide\",\"country\":\"\",\"placeType\":{\"name\":\"Supername\",\"code\":19},\"countryCode\":null,\"woeid\":1}],\"use_cookie_personalization\":true,\"sleep_time\":{\"start_time\":null,\"enabled\":false,\"end_time\":null},\"geo_enabled\":false,\"time_zone\":{\"tzinfo_name\":\"America\\/Los_Angeles\",\"name\":\"Pacific Time (US & Canada)\",\"utc_offset\":-28800},\"discoverable_by_email\":true}")}
  context 'readers' do
    it 'should give us the word' do      
      word = Entry.new({:word => 'hat', :definition => 'head garment'}) 
      word.word.should eq 'hat'
    end

    it 'should give us the definition' do
      word = Entry.new({:word => 'hat', :definition => 'head garment'})
      word.definition.should eq 'head garment'
    end
  end

  context '.save' do 
    it 'adds a save to the wiktionary' do 
      entry = Entry.new({:word => 'foo', :definition => 'bar'})
      stub = stub_request(:post, 'http://localhost:3000/entries').to_return(:status => 200, :body => {:entry => {:id => 13, :word => 'foo', :definition => 'bar'}}.to_json)
      entry.save
      stub.should have_been_requested
    end
  end 

  # context '.view_word' do 
  #   it 'requests the word from the server' do 
  #     id = 13
  #     stub = stub_request(:get, "http://localhost:3000/13").
  #        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.7'}).
  #        to_return(:status => 200, :body => {:entry => {:id => 13, :word => 'foo', :definition => 'bar'}}.to_json)
  #     Entry.view_word(13)
  #     stub.should have_been_requested
  #   end

  #   it 'shows a word and its definition in the wiktionary' do
  #     id = 13
  #     stub_request(:get, "http://localhost:3000/13").
  #        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.7'}).
  #        to_return(:status => 200, :body => {:entry => {:id => 13, :word => 'foo', :definition => 'bar'}}.to_json)
  #     word = Entry.view_word(13)
  #     word['definition'].should eq 'bar'
  #   end
  # end

  # context '.all' do
  #   it 'shows all of the words in the wiktionary' do 
      
  #     stub_request(:get, "http://localhost:3000/entries").
  #        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.7'}).
  #        to_return(:status => 200, :body => [{:entry => {:id => 1, :word => 'foo', :definition => 'bar'}}, {:entry => {:id => 2, :word => 'shoe', :definition => 'barn'}}].to_json)
  #     # binding.pry
  #     words = Entry.all
  #     words.first.word.should eq 'foo'
  #   end
  # end

  context '.edit_definition' do 
    it 'allows user to edit a words definition' do 
      id = 1
      stub = stub_request(:put, "http://localhost:3000/entries/#{id}").with(:definition => 'things')
      new_definition = Entry.edit_definition(id, 'lots of stuff')
      stub.should have_been_requested
    end
  end

  context '.edit_word' do 
    it 'allows user to edit a words name' do 
      id = 1
      stub = stub_request(:put, "http://localhost:3000/entries/#{id}").with(:word => 'stuff')
      new_definition = Entry.edit_definition(id, 'crud')
      stub.should have_been_requested
    end
  end

  context '.delete' do
    it 'deletes a word' do
      id = 1
      word = Entry.new(:id => 6, :word => 'hat', :definition => 'head garment')
      stub = stub_request(:delete, "http://localhost:3000/entries/#{id}")
      Entry.delete(id)
      stub.should have_been_requested
    end
  end
end