require 'spec_helper'

describe 'AC3' do
  before :all do
    @un_solvable_matrix = [
      [1,7,3,nil,nil,nil,nil,nil,nil],
      [4,2,nil,8,nil,nil,nil,nil,nil],
      [6,5,9,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,5,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,8,1]
    ]
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

    @arcs = []

  end

  describe 'valid?' do
    ac = AC3.new
    it 'should return false if there are no possibilities' do
      cell = {value: nil, possible: [], x: 0, y: 0}
      solution = ac.valid?(cell)
      expect(solution).to equal(false)

    end

    it 'should return true if there is at least one possibility' do
      cell = {value: nil, possible: [1], x: 0, y: 0}
      solution = ac.valid?(cell)
      expect(solution).to equal(true)

    end

    it 'should return true if there are > 1 possibilities' do
      cell = {value: nil, possible: (1..9).to_a, x: 0, y: 0}
      solution = ac.valid?(cell)
      expect(solution).to equal(true)

    end
  end

  describe 'csp' do
    ac = AC3.new

    it 'should return a collection of hashes with a sparce matrix' do
      @arcs = ac.csp(@matrix)
      expect(@arcs[0]).to be_kind_of(Object)
    end

    it 'should return a collection of hashes with solvable matrix' do
      @arcs = ac.csp(@solvable)
      expect(@arcs[0]).to be_kind_of(Object)
    end

    it 'should return a collection of hashes with unsolvable matrix' do
      @arcs = ac.csp(@un_solvable_matrix)
      expect(@arcs[0]).to be_kind_of(Object)
    end

  end

  describe 'enqueue_neighbours_row' do
    ac = AC3.new

    it 'should increase the number of items in the arcs queue from a given row' do
      row_index = 0
      @arcs = ac.csp(@un_solvable_matrix)
      new_arcs = ac.enqueue_neighbours_row(@arcs, row_index)
      expect(new_arcs.length).to be > @arcs.length
    end
  end

  describe 'enqueue_neighbours_column' do
    ac = AC3.new

    it 'should increase the number of items in the arcs queue from a given column' do
      column_index = 0
      @arcs = ac.csp(@un_solvable_matrix)
      new_arcs = ac.enqueue_neighbours_column(@arcs, column_index)
      expect(new_arcs.length).to be > @arcs.length
    end
  end

  describe 'enqueue_neighbours_inner_matrix' do
    ac = AC3.new

    it 'should increase the number of items in the arcs queue from a given column' do
      column_index = 0
      row_index = 0
      @arcs = ac.csp(@un_solvable_matrix)
      new_arcs = ac.enqueue_neighbours_inner_matrix(@arcs, row_index, column_index)
      expect(new_arcs.length).to be > @arcs.length
    end

    it 'should increase the number of items in the arcs queue from a given column' do
      column_index = 5
      row_index = 3
      @arcs = ac.csp(@un_solvable_matrix)
      new_arcs = ac.enqueue_neighbours_inner_matrix(@arcs, row_index, column_index)
      expect(new_arcs.length).to be > @arcs.length
    end
  end

  describe 'ac3' do
    ac = AC3.new

    describe 'impossible' do
      it 'should return false for result and the current matrix when impossible matrix' do
        @arcs = []
        @arcs = ac.csp(@un_solvable_matrix)
        matrix, result = ac.ac3(@un_solvable_matrix, @arcs)
        expect(result).to be(false)
        expect(matrix).to be_kind_of(Array)
      end
    end

    describe 'possible' do
      it 'should return true for result and the current matrix for a solvable matrix' do
        @arcs = []
        @arcs = ac.csp(@solvable)
        matrix, result = ac.ac3(@solvable, @arcs)
        expect(result).to be(true)
        expect(matrix).to be_kind_of(Array)
      end

      it 'should return true for result and the current matrix for a sparse matrix' do
        @arcs = []
        @arcs = ac.csp(@matrix)
        matrix, result = ac.ac3(@matrix, @arcs)
        expect(result).to be(true)
        expect(matrix).to be_kind_of(Array)
      end

      it 'should return true for result and the current matrix for a hard matrix' do
        @arcs = []
        @arcs = ac.csp(@hard)
        matrix, result = ac.ac3(@hard, @arcs)
        expect(result).to be(true)
        expect(matrix).to be_kind_of(Array)
      end

      it 'should return true for result and the current matrix for an easy matrix' do
        @arcs = []
        @arcs = ac.csp(@easy)
        matrix, result = ac.ac3(@easy, @arcs)
        expect(result).to be(true)
        expect(matrix).to be_kind_of(Array)
      end
    end

  end

end
