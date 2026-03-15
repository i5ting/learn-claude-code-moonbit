// Blackbox tests run against the package's public API. Use `@claude_mbt` to import.
// Prefer high-level behaviors over implementation details.
// Run `moon test` to execute and `moon test --update` to refresh snapshots.

test "send_message returns JSON" {
  let config = @claude_mbt.default_config()
  let result = @claude_mbt.send_message(config, "hello")
  assert_true(result.contains("\"model\":\"claude-opus-4-6\""))
  assert_true(result.contains("\"content\":\"hello\""))
}
