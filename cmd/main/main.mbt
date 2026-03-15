///|
/// Entry point for the CLI or runnable program in this template.
/// Keep main focused; move logic into the library package.
/// Run with `moon run cmd/main` from the project root.
async fn main {
  let config = @claude_mbt.config_from_env()
  let result = @claude_mbt.send_message(config, "hello")
  println(result)
}
