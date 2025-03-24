require 'json'
require 'credit_card_sanitizer'
require 'sinatra'

post '/' do
  content_type :json

  begin
    request_body = JSON.parse(request.body.read)
    result = { processed: true, sanitized_text: CreditCardSanitizer.new.sanitize!(request_body['text']) }
    result.to_json
  rescue JSON::ParserError => e
    status 400
    { error: 'Invalid JSON', details: e.message }.to_json
  rescue => e 
    status 500
    { error: 'Server error', details: e.message }.to_json
  end
end


