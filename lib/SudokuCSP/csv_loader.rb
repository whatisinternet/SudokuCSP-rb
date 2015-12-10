class CSVLoader

  def load(file_name_with_path)
    lines = File.readlines file_name_with_path
    lines = lines.map do |l|
      row = l.chomp.split(',')
      row.reduce([]) do |updated_row, ch|
        if ch == "0"
          updated_row.push nil
        else
          updated_row.push ch.to_i
        end
        updated_row
      end
    end
    lines
  end
end
