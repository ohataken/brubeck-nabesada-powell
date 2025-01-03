# frozen_string_literal: true

require "uri"
require "net/http"
require "nokogiri"

module Cards
  class Card
    def hostname
      ENV.fetch("CARD_HOSTNAME", "example.com")
    end

    def uri_string
      "https://#{hostname}/cards"
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

    def document
      @document ||= Nokogiri::HTML(encoded_body)
    end
  end
end
