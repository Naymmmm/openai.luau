local OpenAI = require("../src/openai")
local Environment = require("../env.luau")
local Context = OpenAI.new(Environment.ApiKey, "gpt-4o", "You are an assistant.")

local result = Context:Complete("make 15 random sentences")

print(result)
