class ArcReduce

  def block_lookup(x,y)
    x_offset = x == 0 ? 0 : ((x) % 3)
    y_offset = y == 0 ? 0 : ((y) % 3)
    [x - x_offset, y - y_offset]
  end

  def sub_matrix(matrix, x, y)

    top_left = block_lookup(x,y)

    matrix[top_left[1]..(top_left[1] + 2)].map do |row|
      row[top_left[0]..(top_left[0] + 2)]
    end

  end

  def reject_rows(matrix, cell, y)
    row = matrix[y].compact
    cell[:possible].reject!{|a| row.include? a}
    cell
  end

  def reject_columns(matrix, cell, x)
    column = matrix.map{|row| row[x] }.compact
    cell[:possible].reject!{|a| column.include? a}
    cell
  end

  def reject_three_by_three(matrix, cell, x, y)
    sub_matrix = sub_matrix(matrix, x, y)
    flattened = sub_matrix.flatten.compact
    cell[:possible].reject!{|a| flattened.include? a}
    cell
  end

end
