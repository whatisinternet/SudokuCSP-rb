class BacktrackingSolver
  def copy_matrix(matrix)
    matrix.clone
  end

  def solve(matrix)
    ac3 = AC3.new
    arcs = ac3.csp(matrix)
    matrix, result, arc, arc_size = ac3.ac3(matrix, arcs)
    if result
      return helper(matrix, 0,0)
    else
      return matrix
    end
  end


  private
    def helper(matrix, row, column)
      return matrix if solved?(matrix)
      return matrix if row == 9 || column == 9
      if matrix[row][column] == nil
        ac3 = AC3.new
        arcs = ac3.csp(matrix)
        matrix, result, arc, arc_size = ac3.ac3(matrix, arcs)
        return matrix if solved?(matrix)
        (1..9).each do |index|
            possible = {possible: [index], x: column, y: row}
            arc_possible = reduce_arc(matrix, possible)
            if arc_possible[:possible].length > 0
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
        end
      else
        if column == 8
          helper(matrix, row + 1, 0)
        else
          helper(matrix, row, column + 1)
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
