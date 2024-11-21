
# 🤖 openai.luau

An OpenAI API wrapper for Lune.

## Acknowledgements

- OpenAI, for the API
- The Lune Team, for Lune
- Roblox, for Luau
- The Rojo Team, for Rokit

## API Reference

#### Create a new context

```lua
  self.New(api_key: string, model: string, systemprompt: string): Context
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | The API key used to interface with the OpenAI API. |
| `model` | `string` | The model to be used with the prompts. |
| `systemprompt` | `string` | The system prompt to be sent to the completion. |

#### Chat with the Context

```lua
  Context:Complete(message: string): response: string, success: bool?
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `message` | `string` | The message to be sent to the completion. |
