require 'spec_helper'

describe 'CSVLoader' do

  before :all do
    @file_name = "#{Dir.pwd}/spec/fixtures/fixture.csv"
  end
  describe 'load' do

    loader = CSVLoader.new
    it 'should return an Array' do
      matrix = loader.load(@file_name)
      expect(matrix).to be_kind_of(Array)
    end

    it 'should return an nxn matrix' do
      matrix = loader.load(@file_name)
      length = matrix.count
      matrix.each do |row|
        expect(row.length).to equal(length)
      end
    end

    it 'should return an nxn matrix of integers with no 0\'s' do
      matrix = loader.load(@file_name)
      matrix.each do |row|
        row.each do |column|
          expect(column).not_to equal(0.to_i)
          expect(column).to be_kind_of(Integer) unless column.nil?
        end
      end
    end

  end

end
