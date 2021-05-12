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

    puts result
    return 'Can not fit ad in ad board' if result == false

    start_with_row(ad) if result == 'start_with_row_can_fit'
    start_with_col(ad) if result == 'start_with_col_can_fit'
    p @board
    p @next_row
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
    (row..(ad.ad_rows - 1)).each do |row|
      (col..(ad.ad_cols - 1)).each do |col|
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
    (row..(ad.ad_rows - 1)).each do |row|
      (col..(ad.ad_cols - 1)).each do |col|
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
    (row..(ad.ad_rows - 1)).each do |row|
      (col..(ad.ad_cols - 1)).each do |col|
        @board[row][col] = ad.ad_id
      end
    end

    @next_row = [ad.ad_rows, ad.ad_cols]
  end

  def start_with_col(ad)
    row = @next_col[0]
    col = @next_col[1]
    (row..(ad.ad_rows - 1)).each do |row|
      (col..(ad.ad_cols - 1)).each do |col|
        @board[row][col] = ad.ad_id
      end
    end

    @next_col = [ad.ad_rows, ad.ad_cols]
  end

  def navigate_and_update(origin, rows, cols)
    row = origin[0]
    col = origin[1]
    (row..(ad.ad_rows - 1)).each do |row|
      (col..(ad.ad_cols - 1)).each do |col|
        @board[row][col] = 0
      end
    end    
  end

end


ad_board = AdBoard.new
ad = Ad.new(3,2,"BW")
ad_board.place_ad(ad)

new_ad = Ad.new(3,2,"BW")
ad_board.place_ad(ad)

