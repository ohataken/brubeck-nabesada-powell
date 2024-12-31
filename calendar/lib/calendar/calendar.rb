# frozen_string_literal: true

require "uri"
require "net/http"
require "nokogiri"

module Calendar
  class Calendar
    attr_accessor :id

    def initialize id
      @id = id
    end

    def hostname
      ENV.fetch("CALENDAR_HOSTNAME", "example.com")
    end

    def uri_string
      "https://#{hostname}/live/?cal=#{@id}"
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