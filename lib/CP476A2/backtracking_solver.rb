class BacktrackingSolver
  def copy_matrix(matrix)
    matrix.clone
  end

  def solve(matrix)
    old_matrix = matrix.clone
    ac3 = AC3.new
    arcs = ac3.csp(matrix)
    matrix, result, arc = ac3.ac3(matrix, arcs)
    if result
      return helper(matrix, 0,0), result
    else
      return matrix, result
    end
  end


  private
    def helper(matrix, row, column)
      if solved?(matrix)
        return matrix
      end
      if row == 8 && column == 8
        return matrix
      end
      ac3 = AC3.new
      arcs = ac3.csp(matrix)
      origional_matrix = matrix.clone
      matrix, result, arc = ac3.ac3(matrix, arcs)
      matrix = origional_matrix if result == false
      (1..9).each do |index|
        if matrix[row][column] == nil
          possible = {possible: [index], x: column, y: row}
          arc = reduce_arc(matrix, possible)
          if arc[:possible].length > 0
            matrix[row][column] = index
            if column == 8
              helper(matrix, row + 1, 0)
            else
              helper(matrix, row, column + 1)
            end
          else
            if column == 8
              helper(matrix, row + 1, 0)
            else
              helper(matrix, row, column + 1)
            end
          end
        else
          if column == 8
            helper(origional_matrix, row + 1, column)
          else
            helper(origional_matrix, row, column + 1)
          end
        end
      end
      matrix
    end

    def solved?(matrix)
      matrix.each do |row|
        row.each do |column|
          if column == nil
            return false
          end
        end
      end
      true
    end


    def reduce_arc(matrix, arc)
      ar = ArcReduce.new
      arc = ar.reject_rows(matrix, arc, arc[:y])
      arc = ar.reject_columns(matrix, arc, arc[:x])
      ar.reject_three_by_three(matrix, arc, arc[:x], arc[:y])
    end
end
