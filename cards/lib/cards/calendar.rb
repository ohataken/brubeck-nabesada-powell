# frozen_string_literal: true

require "date"
require "json"
require "uri"
require "net/http"
require_relative "card"

module Cards
  class Calendar
    attr_accessor :date

    def initialize date
      @date = date
    end

    def hostname
      ENV.fetch("CALENDAR_HOSTNAME", "example.com")
    end

    def month_query
      date.strftime("%Y%m")
    end

    def uri_string
      "https://#{hostname}/calendar?id=#{month_query}"
    end

    def uri
      @uri ||= URI.parse(uri_string)
    end

    def body
      @body ||= Net::HTTP.get(uri)
    end

    def encoded_body
      body.force_encoding(Encoding::UTF_8)
    end

    def to_hash
      @hash ||= JSON.parse(encoded_body)
    end

    def cards
      @cards ||= to_hash["cards"].map { |c| Card.new(date, c) }
    end
  end
end
