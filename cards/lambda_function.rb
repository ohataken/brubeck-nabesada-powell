require "lib/cards"
require "io/console"
require "stringio"

module LambdaFunction
  class Handler
    def self.process(event:, context:)
      id = event["queryStringParameters"]["id"]
      date = Date.parse(id)
      calendar = Cards::Calendar.new date
      card = calendar.cards.find { |c| c.date == date } || {}

      {
        isBase64Encoded: false,
        statusCode: 200,
        headers: {
          "Cache-Control": "public, max-age=86400"
        },
        body: card.to_hash.to_json
      }
    end
  end
end
