local OpenAI = require("../src/openai")
local Environment = require("../env.luau")
local Context = OpenAI.new(Environment.ApiKey, "gpt-4o-mini", "Tacos")

local result = Context:Complete("Tacos!")

print(result)
