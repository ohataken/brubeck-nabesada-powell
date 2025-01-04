# frozen_string_literal: true

require "json"
require "uri"
require "net/http"
require "nokogiri"

module Lives
  class Live
    attr_accessor :id

    def initialize id
      @id = id
    end

    def hostname
      ENV.fetch("LIVES_HOSTNAME", "example.com")
    end

    def uri_string
      "https://#{hostname}/live/#{@id}/"
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

    def description
      document.at_css("section.eventDetail > h3.eventTitle").text
    end

    def event_required_definition_list
      document.css("section.eventDetail > div.eventRequired > dl")
    end

    def title
      event_required_definition_list[0].at_css("dd > p").text
    end

    def event_detail_nodes
      event_required_definition_list[1].css("dd > p")
    end

    def event_detail
      event_detail_nodes.map(&:text)
    end

    def member_nodes
      event_required_definition_list[2].css("dd > p")
    end

    def member
      member_nodes.map(&:text)
    end

    def to_hash
      {
        title: title,
        description: description,
        event_detail: event_detail,
        member: member,
      }
    end
  end
end
