require_relative 'arc_reduce'

class AC3

  # If time, refactor this
  def ac3(matrix, arcs)

    ar = ArcReduce.new
    equal_arc = []
    while arcs.length > 0

      puts "Queue length: #{arcs.length}"

      arc = arcs.shift

      temp_cell = ar.reject_rows(matrix, arc, arc[:y])
      unless temp_cell[:possible].length == arc[:possible].length
        arcs = enqueue_neighbours_row(arcs, arc[:y])
      end

      temp_cell = ar.reject_columns(matrix, temp_cell, arc[:x])
      unless temp_cell[:possible].length == arc[:possible].length
        arcs = enqueue_neighbours_column(arcs, arc[:x])
      end

      temp_cell = ar.reject_three_by_three(matrix, temp_cell, arc[:x], arc[:y])
      unless temp_cell[:possible].length == arc[:possible].length
        arcs = enqueue_neighbours_inner_matrix(arcs, arc[:y], arc[:x])
      end

      if temp_cell[:possible].length == 1
        matrix[temp_cell[:y]][temp_cell[:x]] = temp_cell[:possible][0]
      end

      unless temp_cell == arc
        arcs.push temp_cell
      else
        equal_arc.push temp_cell
      end

      return matrix, false, equal_arc if !valid? arc

    end

    return matrix, true, equal_arc

  end

  def valid?(cell)
    cell[:possible].length != 0
  end

  # UGLY
  def csp(matrix)
    (0..8).map do |outer|
      (0..8).map do |inner|
        if matrix[outer][inner] == nil
          {
            value: matrix[outer][inner],
            possible: (1..9).to_a,
            x: inner,
            y: outer
          }
        end
      end.compact
    end.flatten
  end

  def enqueue_neighbours_row(arc, row_index)
    appendable = arc.reject{|a| a[:y] != row_index}
    arc + appendable
  end

  def enqueue_neighbours_column(arc, column_index)
    appendable = arc.reject{|a| a[:x] != column_index}
    arc + appendable
  end

  def enqueue_neighbours_inner_matrix(arc, row_index, column_index)
    ar = ArcReduce.new
    top_left =  ar.block_lookup(column_index, row_index)

    x_offset = column_index == 0 ? 0 : ((column_index) % 3)
    y_offset = row_index == 0 ? 0 : ((row_index) % 3)

    sub_arc = (top_left[1]..(top_left[1] + 2)).map do |row|
      (top_left[0]..(top_left[0] + 2)).map do |column|
        arc.reject do |a|
          a[:x] != (column + x_offset) ||  a[:y] != (row + y_offset)
        end
      end
    end.flatten()
    arc + sub_arc
  end

end
