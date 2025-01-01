# frozen_string_literal: true

require "json"
require "nokogiri"

module Calendar
  class Card
    attr_accessor :node

    def initialize node
      @node = node
    end

    def anchor
      @anchor ||= @node.at_css("a")
    end

    def day_node
      @day_node ||= @node.at_css("a > div.m_calCardHead > div.m_calCardDay")
    end

    def day
      day_node&.children&.at(0)&.text&.strip.to_i
    end

    def image_node
      @image_node ||= @node.at_css("a > div.m_calCardHead > div.m_calCardImage > img")
    end

    def text_node
      @text_node ||= @node.at_css("a > div.m_calCardBody > p.m_calCardText")
    end

    def category_node
      @category_node ||= @node.at_css("a > div.m_calCardBody > span.m_calCardCat")
    end

    def to_hash
      {
        anchor: {
          href: anchor && anchor["href"]
        },
        day:,
        image: {
          src: image_node && image_node["src"]
        },
        body: {
          children: text_node&.children&.map { |e| {text: e.text} }
        },
        category: {
          content: category_node&.content
        }
      }
    end
  end
end
