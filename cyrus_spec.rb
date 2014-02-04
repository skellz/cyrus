require 'rspec'
require_relative 'cyrus'

describe 'CyrusReader' do 
  it 'should accept a file' do 
  	expect(CyrusReader.new("this.txt").filename).to eql 'this.txt'
  end

  it 'should properly accept a pipe delimited file' do 
  end

  it 'should properly accept a comma delimited file' do 
  end

  it 'should properly accept a space delimited file' do 
  end

    
end