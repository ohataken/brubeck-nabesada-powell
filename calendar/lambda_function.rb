require "lib/calendar"
require "io/console"
require "stringio"

module LambdaFunction
  class Handler
    def self.process(event:,context:)
      id = event["queryStringParameters"]["id"]
      calendar = Calendar::Calendar.new id

      {
        isBase64Encoded: false,
        statusCode: 200,
        headers: {
          "Cache-Control": "public, max-age=3600"
        },
        body: calendar.to_hash.to_json
      }
    end
  end
end
