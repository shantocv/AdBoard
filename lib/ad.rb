require 'securerandom'

class Ad
  attr_accessor :ad_id, :ad_type, :ad_rows, :ad_cols, :ad_cost, :origin
  def initialize(n=1, m=1, type="BW")
    cost = {
      "BW": 2,
      "CL": 8,
      "FL": 64
    }

    @ad_type = type
    @ad_rows = n
    @ad_cols = m
    @ad_cost = cost[type]
    @origin = nil
    @ad_id = SecureRandom.hex(4)
  end
end