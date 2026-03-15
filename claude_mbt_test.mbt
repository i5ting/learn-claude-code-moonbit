test "config_from_env loads configuration" {
  let config = @claude_mbt.config_from_env()
  assert_true(config.api_key.length() > 0)
}
