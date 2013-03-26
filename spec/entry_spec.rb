require 'spec_helper'

describe Entry do
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
      stub = stub_request(:post, 'http://wikitionarysmpjl.herokuapp.com/entries').to_return(:status => 200, :body => {:entry => {:id => 13, :word => 'foo', :definition => 'bar'}}.to_json)
      entry.save
      stub.should have_been_requested
    end
  end 

  context '.view_word' do 
    it 'requests the word from the server' do 
      id = 13
      stub = stub_request(:get, "http://localhost:3000/entries/13").
         to_return(:status => 200, :body => {:entry => {:id => 13, :word => 'foo', :definition => 'bar'}}.to_json)
      Entry.view_word(13)
      stub.should have_been_requested
    end

    it 'shows a word and its definition in the wiktionary' do
      id = 13
      stub_request(:get, "http://localhost:3000/entries/#{id}").
         to_return(:status => 200, :body => {:entry => {:id => 13, :word => 'foo', :definition => 'bar'}}.to_json)
      word = Entry.view_word(13)
      word['definition'].should eq 'bar'
    end
  end

  context '.all' do
    it 'shows all of the words in the wiktionary' do       
      stub_request(:get, "http://localhost:3000/entries").
         to_return(:status => 200, :body => [{:entry => {:id => 1, :word => 'foo', :definition => 'bar'}}, {:entry => {:id => 2, :word => 'shoe', :definition => 'barn'}}].to_json)
      words = Entry.all
      words.first.word.should eq 'foo'
    end
  end

  context '.edit_definition' do 
    it 'allows user to edit a words definition' do 
      id = 1
      stub = stub_request(:put, "http://wikitionarysmpjl.herokuapp.com/entries/#{id}").with(:definition => 'things')
      new_definition = Entry.edit_definition(id, 'lots of stuff')
      stub.should have_been_requested
    end
  end

  context '.edit_word' do 
    it 'allows user to edit a words name' do 
      id = 1
      stub = stub_request(:put, "http://wikitionarysmpjl.herokuapp.com/entries/#{id}").with(:word => 'stuff')
      new_definition = Entry.edit_definition(id, 'crud')
      stub.should have_been_requested
    end
  end

  context '.delete' do
    it 'deletes a word' do
      id = 1
      word = Entry.new(:id => 1, :word => 'hat', :definition => 'head garment')
      stub = stub_request(:delete, "http://wikitionarysmpjl.herokuapp.com/entries/#{id}")
      Entry.delete(id)
      stub.should have_been_requested
    end
  end
end