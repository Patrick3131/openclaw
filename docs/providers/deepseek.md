---
summary: "Use DeepSeek's OpenAI-compatible API in OpenClaw"
read_when:
  - You want to use DeepSeek models in OpenClaw
---
# DeepSeek

DeepSeek provides an OpenAI-compatible API. OpenClaw registers it as the `deepseek`
provider and uses the OpenAI chat completions API.

## Quick setup (recommended)

1) Set `DEEPSEEK_API_KEY`.
2) Set your default model.

```json5
{
  env: { DEEPSEEK_API_KEY: "sk-..." },
  agents: {
    defaults: {
      model: { primary: "deepseek/deepseek-chat" }
    }
  }
}
```

## Explicit provider config (advanced)

If you want to pin the provider config in `openclaw.json`, include a model list
to satisfy schema validation:

```json5
{
  env: { DEEPSEEK_API_KEY: "sk-..." },
  models: {
    mode: "merge",
    providers: {
      deepseek: {
        baseUrl: "https://api.deepseek.com/v1",
        api: "openai-completions",
        models: [
          {
            id: "deepseek-chat",
            name: "DeepSeek Chat",
            reasoning: false,
            input: ["text"],
            cost: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0 },
            contextWindow: 128000,
            maxTokens: 8000
          },
          {
            id: "deepseek-reasoner",
            name: "DeepSeek Reasoner",
            reasoning: true,
            input: ["text"],
            cost: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0 },
            contextWindow: 128000,
            maxTokens: 64000
          }
        ]
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
