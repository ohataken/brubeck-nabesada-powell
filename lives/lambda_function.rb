require "lib/lives"
require "io/console"
require "stringio"

module LambdaFunction
  class Handler
    def self.process(event:, context:)
      id = event["queryStringParameters"]["id"]
      live = Lives::Live.new id

      {
        isBase64Encoded: false,
        statusCode: 200,
        headers: {
          "Cache-Control": "public, max-age=86400"
        },
        body: live.to_hash.to_json
      }
    end
  end
end
