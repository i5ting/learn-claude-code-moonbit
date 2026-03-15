///|
struct Config {
  api_key : String
  model : String
  max_tokens : Int
  url : String
}

///|
pub fn default_config() -> Config {
  Config::{
    api_key: "",
    model: "claude-opus-4-6",
    max_tokens: 10,
    url: "https://code.newcli.com",
  }
}

///|
pub fn config_from_env() -> Config {
  load_env_file(".env")
  let api_key = get_env_or("ANTHROPIC_API_KEY", "")
  let model = get_env_or("MODEL_ID", "claude-opus-4-6")
  let max_tokens = @strconv.parse_int(get_env_or("MAX_TOKENS", "10")) catch {
    _ => 10
  }
  let url = get_env_or("ANTHROPIC_BASE_URL", "https://code.newcli.com")
  Config::{ api_key, model, max_tokens, url }
}

///|
let env_vars : @hashmap.HashMap[String, String] = @hashmap.new()

///|
fn load_env_file(path : String) -> Unit {
  let content = @fs.read_file_to_string(path) catch { _ => return }
  for line in content.split("\n") {
    let s = line.to_string()
    if s.is_empty() || s.has_prefix("#") {
      continue
    }
    let parts = s.split("=").collect()
    if parts.length() >= 2 {
      let key = parts[0].to_string()
      let value = parts[1].to_string()
      env_vars.set(key, value)
    }
  }
}

///|
fn get_env_or(key : String, default : String) -> String {
  env_vars.get(key).unwrap_or(default)
}

///|
pub async fn send_message(config : Config, message : String) -> String {
  let body = "{\"model\":\"" +
    config.model +
    "\",\"max_tokens\":" +
    config.max_tokens.to_string() +
    ",\"messages\":[{\"role\":\"user\",\"content\":\"" +
    message +
    "\"}]}"

  let headers = {
    "x-api-key": config.api_key,
    "anthropic-version": "2023-06-01",
    "content-type": "application/json",
  }

  let client = @http.Client::new(config.url)
  let _response = client.post("/claude/aws/v1/messages", extra_headers=headers, body)
  client.read_all().text()
}
