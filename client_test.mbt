///|
test "config_from_env loads environment variables" {
  let config = config_from_env()
  assert_true(config.api_key.length() > 0)
  assert_eq(config.model, "claude-sonnet-4-6")
  assert_eq(config.url, "https://code.newcli.com")
}

///|
async test "send_message with config_from_env " {
  let config = @claude_mbt.config_from_env()
  let message = "{\"role\":\"user\",\"content\":\"hello\"}"
  let result = @claude_mbt.send_message(config, message)

  // {"content":[{"text":"Hey! How can I help you today?","type":"text"}],"model":"claude-sonnet-4-6","role":"assistant","stop_reason":"end_turn","stop_sequence":null,"type":"message","usage":{"cache_creation":{"ephemeral_1h_input_tokens":0,"ephemeral_5m_input_tokens":0},"cache_creation_input_tokens":0,"cache_read_input_tokens":0,"inference_geo":"not_available","input_tokens":4,"output_tokens":11,"service_tier":"standard"}}
  assert_true(result.contains("Hey! How can I help you today?"))
}
