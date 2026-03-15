struct Message {
  role : String
  content : String
} derive(Show)

struct Request {
  model : String
  max_tokens : Int
  messages : Array[Message]
} derive(Show)

pub fn send_message(api_key : String, message : String) -> String {
  let _req = Request::{
    model: "claude-opus-4-6",
    max_tokens: 10,
    messages: [Message::{ role: "user", content: message }]
  }

  let _url = "https://code.newcli.com/claude/aws/v1/messages"
  let _headers = [
    ("x-api-key", api_key),
    ("anthropic-version", "2023-06-01"),
    ("content-type", "application/json")
  ]

  "Not implemented"
}
