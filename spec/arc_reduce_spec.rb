require 'spec_helper'

describe 'ArcReduce' do
  before :all do
    @matrix = [
      [1,7,nil,nil,nil,nil,nil,nil,nil],
      [4,2,nil,nil,nil,nil,nil,nil,nil],
      [6,5,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,5,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,8,1]
    ]

  end

  describe 'block_lookup' do
    ar = ArcReduce.new
    it 'should return an object with updated possible values rejecting from an nxn matrix' do
      x = 0
      y = 5
      top_left_indexes = ar.block_lookup(x,y)
      expect(top_left_indexes[0]).to eq(0)
      expect(top_left_indexes[1]).to eq(3)
    end
  end

  describe 'block_lookup' do
    ar = ArcReduce.new
    it 'should return an object with updated possible values rejecting from an nxn matrix' do
      sub_matrix = [
        [nil,nil,nil],
        [nil,5,nil],
        [nil,nil,nil]
      ]
      x = 4
      y = 5
      top_left_indexes = ar.sub_matrix(@matrix,x,y)
      expect(top_left_indexes).to eq(sub_matrix)
    end
  end


  describe 'reject_rows' do
    ar = ArcReduce.new
    it 'should return an object with updated possible values rejecting from an nxn matrix' do

      y = 0
      cell = {value: nil, possible: [1,2,3,4,5,6,7,8,9]}
      newCell = ar.reject_rows(@matrix, cell, y)

      expect(newCell[:possible]).to eq([2,3,4,5,6,8,9])
    end
  end

  describe 'reject_columns' do
    ar = ArcReduce.new
    it 'should return an object with updated possible values rejecting from an nxn matrix' do
      x = 0
      cell = {value: nil, possible: [1,2,3,4,5,6,7,8,9]}
      newCell = ar.reject_columns(@matrix, cell, x)
      expect(newCell[:possible]).to eq( [2,3,5,7,8,9] )
    end
  end

  describe 'reject_three_by_three' do
    ar = ArcReduce.new
    it 'should return an object with updated possible values rejecting from an nxn matrix' do
      x = 4
      y = 5
      cell = {value: nil, possible: (1..9).to_a}
      newCell = ar.reject_three_by_three(@matrix, cell, x, y)
      expect(newCell[:possible]).to eq([1,2,3,4,6,7,8,9] )
    end
  end

  describe 'reject_three_by_three' do
    ar = ArcReduce.new
    it 'should return an object with updated possible values rejecting from an nxn matrix' do
      x = 0
      y = 0
      cell = {value: nil, possible: (1..9).to_a}
      newCell = ar.reject_three_by_three(@matrix, cell, x, y)
      expect(newCell[:possible]).to eq([3,8,9])
    end
  end

end
