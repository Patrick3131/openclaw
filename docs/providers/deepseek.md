---
summary: "Use DeepSeek's OpenAI-compatible API in OpenClaw"
read_when:
  - You want to use DeepSeek models in OpenClaw
---
# DeepSeek

DeepSeek provides an OpenAI-compatible API. OpenClaw registers it as the `deepseek`
provider and uses the OpenAI chat completions API.

## Quick setup

1) Set `DEEPSEEK_API_KEY`.
2) Set your default model to a DeepSeek model id.

```json5
{
  env: { DEEPSEEK_API_KEY: "sk-..." },
  models: {
    mode: "merge",
    providers: {
      deepseek: {
        baseUrl: "https://api.deepseek.com/v1",
        api: "openai-completions"
      }
    }
  },
  agents: {
    defaults: {
      model: { primary: "deepseek/deepseek-chat" }
    }
  }
}
```

## Models

- `deepseek/deepseek-chat` (non-thinking)
- `deepseek/deepseek-reasoner` (thinking)

## Notes

- The base URL uses the OpenAI-compatible `/v1` path.
- Model refs always use `provider/model` (see [/concepts/models](/concepts/models)).
