async fn main {
  let config = @claude_mbt.config_from_env()
  let message = "{\"role\":\"user\",\"content\":\"hello\"}"
  let result = @claude_mbt.send_message(config, message)
  println(result)
}
