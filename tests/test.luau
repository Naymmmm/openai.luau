local openai = require("../src/openai")
local env = require("../env")
local context = openai.New(env.ApiKey, "You are a test assistant formulated via OpenAI.luau")
local prompt = "Who are you?"

local result, success, code = context:Complete(prompt, "gpt-4o-mini")
print("Result:", result)
print("Success:", success)
print("Code:", code)