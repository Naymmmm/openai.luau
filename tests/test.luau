local openai = require("../src/openai")
local env = require("../env")
local stdio = require("@lune/stdio")
local context = openai.New(env.ApiKey, "You are a test assistant formulated via OpenAI.luau")
local prompt = "What is the meaning of life?"

local result, success, code = context:Complete(prompt, "gpt-4o-mini")

if success then
	stdio.write(stdio.color("green"))
	print("Completion success! Result: "..result..", response code: "..code)
else
	stdio.write(stdio.color("red"))
	print("Completion failed! Response code: "..code)
end