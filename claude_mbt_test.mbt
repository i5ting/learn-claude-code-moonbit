// Blackbox tests run against the package's public API. Use `@claude_mbt` to import.
// Prefer high-level behaviors over implementation details.
// Run `moon test` to execute and `moon test --update` to refresh snapshots.

test "send_message returns placeholder" {
  let result = @claude_mbt.send_message("test-key", "hello")
  assert_eq(result, "Not implemented")
}
