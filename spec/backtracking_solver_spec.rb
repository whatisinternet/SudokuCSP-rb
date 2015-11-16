require 'spec_helper'

describe 'BacktrackingSolver' do
  before :all do

    @solvable = [[nil,3,5,2,9,nil,8,6,4],
      [nil,8,2,4,1,nil,7,nil,3],
      [7,6,4,3,8,nil,nil,9,nil],
      [2,1,8,7,3,9,nil,4,nil],
      [nil,nil,nil,8,nil,4,2,3,nil],
      [nil,4,3,nil,5,2,9,7,nil],
      [4,nil,6,5,7,1,nil,nil,9],
      [3,5,9,nil,2,8,4,1,7],
      [8,nil,nil,9,nil,nil,5,2,6]]

    @hard = [[4,8,nil,3,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,7,1],
      [nil,2,nil,nil,nil,nil,nil,nil,nil],
      [7,nil,5,nil,nil,nil,nil,6,nil],
      [nil,nil,nil,2,nil,nil,8,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,1,nil,7,6,nil,nil,nil],
      [3,nil,nil,nil,nil,nil,4,nil,nil],
      [nil,nil,nil,nil,5,nil,nil,nil,nil]]

    @easy = [[3,nil,nil,nil,8,nil,nil,nil,nil],
      [nil,nil,nil,7,nil,nil,nil,nil,5],
      [1,nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,3,6,nil],
      [nil,nil,2,nil,nil,4,nil,nil,nil],
      [nil,7,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,6,nil,1,3,nil],
      [nil,4,5,2,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,8,nil,nil]]

  end

  describe 'copy_matrix' do
    it 'should clone a matrix' do
      bts = BacktrackingSolver.new

      new_matrix = bts.copy_matrix(@easy)

      expect(new_matrix).to eq(@easy)
      expect(new_matrix).not_to equal(@easy)

    end
  end

  describe 'solve' do
    it 'should have 0 nil values for solvable' do
      bts = BacktrackingSolver.new
      solved= bts.solve(@solvable)

      solved.each do |row|
        row.each do |column|
          expect(column).not_to be_nil
        end
      end


    end
  end

end
