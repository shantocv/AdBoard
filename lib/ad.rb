require 'securerandom'

class Ad
  attr_accessor :ad_id, :ad_type, :ad_rows, :ad_cols, :ad_cost, :origin

  COST = {
    "BW": 2,
    "CL": 8,
    "FL": 64
  }
  
  def initialize(n=1, m=1, type="BW")
    @ad_type = type
    @ad_rows = n
    @ad_cols = m
    @ad_cost = COST[type]
    @origin = nil
    @ad_id = SecureRandom.hex(4)
  end
end