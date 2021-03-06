require_relative './ad'

class AdBoard
  attr_accessor :remaining_ad_queue, :palced_ad_queue

  def initialize(n=10, m=10)
    @board = Array.new(n) { Array.new(m) { 0 } }
    @palced_ad_queue = []
    @remaining_ad_queue = []
    @next_row = [0,0]
    @next_col = [0,0]
  end

  def add_ad_to_remaining_queue(ad)
    @remaining_ad_queue << ad
  end

  def place_ad(ad)
    result = fit_ad(ad)
    return 'Can not fit ad in ad board' if result == false

    p "result  =>  #{result}"

    start_with_row(ad) if result == 'start_with_row_can_fit'
    start_with_col(ad) if result == 'start_with_col_can_fit'

    p @board
  end

  def remove_ad(ad)
    origin = ad.origin
    rows = ad.ad_rows
    cols = ad.ad_cols

    navigate_and_update(origin, rows, cols)
  end

  private

  def fit_ad(ad)
    result = start_with_row_check(ad)
    if result == false
      result = start_with_col_check(ad)
      if result == false
        false
      else
        result
      end
    else
      result
    end
  end

  def start_with_row_check(ad)
    result = 'start_with_row_can_fit'

    row = @next_row[0]
    col = @next_row[1]
    (row..(row + ad.ad_rows - 1)).each do |row|
      (col..(col + ad.ad_cols - 1)).each do |col|
        if @board[row][col] != 0
          result = false
          break
        end
      end
    end

    result    
  end

  def start_with_col_check(ad)
    result = 'start_with_col_can_fit'

    row = @next_col[0]
    col = @next_col[1]
    (row..(row + ad.ad_rows - 1)).each do |row|
      (col..(col + ad.ad_cols - 1)).each do |col|
        if @board[row][col] != 0
          result = false
          break
        end
      end
    end

    result
  end

  def start_with_row(ad)
    row = @next_row[0]
    col = @next_row[1]

    (row..(row + ad.ad_rows - 1)).each do |row|
      (col..(col + ad.ad_cols - 1)).each do |col|
        p "[#{row}][#{col}]"
        @board[row][col] = ad.ad_id
      end
    end

    find_next_row(ad)
  end

  def find_next_row(ad)
    board_size = @board.size
    row = ad.ad_rows
    do_break = false
    (0..(board_size - 1)).each do |row|
      break if do_break
      (0..(board_size - 1)).each do |col|
        if @board[row][col] == 0
          @next_row = [row, col]
          do_break = true
          break
        end
      end
    end
  end

  def start_with_col(ad)
    row = @next_col[0]
    col = @next_col[1]
    (row..(row + ad.ad_rows - 1)).each do |row|
      (col..(col + ad.ad_cols - 1)).each do |col|
        @board[row][col] = ad.ad_id
      end
    end

    find_next_row(ad)
  end

  def navigate_and_update(origin, rows, cols)
    row = origin[0]
    col = origin[1]
    (row..(row + ad.ad_rows - 1)).each do |row|
      (col..(col + ad.ad_cols - 1)).each do |col|
        @board[row][col] = 0
      end
    end    
  end

end


ad_board = AdBoard.new

ad = Ad.new(3,3,"BW")
ad_board.place_ad(ad)

ad = Ad.new(3,3,"BW")
ad_board.place_ad(ad)

ad = Ad.new(3,3,"BW")
ad_board.place_ad(ad)

ad = Ad.new(3,3,"BW")
ad_board.place_ad(ad)

ad = Ad.new(3,3,"BW")
ad_board.place_ad(ad)

