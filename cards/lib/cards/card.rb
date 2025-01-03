# frozen_string_literal: true

require "date"
require "uri"
require "net/http"

module Cards
  class Card
    def initialize date_month, card
      @date_month = date_month
      @card = card
    end

    def day
      d = @card["day"]
      (d == 0) ? nil : d
    end

    def date
      return if day.nil?
      Date.new(@date_month.year, @date_month.month, day)
    end

    def to_hash
      @card.to_hash
    end
  end
end
