local OpenAI = require("../src/openai")
local Environment = require("../env.luau")
local Context = OpenAI.new(Environment.ApiKey, "gpt-broken", "You are an assistant.")

local result, status = Context:Complete("make 15 random sentences")

if status then
	print(result)
else
	warn("failed test lol, code: " .. result)
end
