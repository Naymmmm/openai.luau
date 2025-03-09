local openai = require("../src/openai")
local env = require("../env")
local stdio = require("@lune/stdio")
local context = openai.New(env.ApiKey, "You are an AI assistant")

stdio.write(stdio.color("purple"))
print("Moderation Test")
stdio.write(stdio.color("reset"))

while true do
    local userMessage = stdio.prompt("text", "Enter a check if it is flagged (or type 'exit' to quit):")

    if userMessage:lower() == "exit" then
        print("Exiting the chat...")
        break
    end

    local flagged = context:Moderate(userMessage)

    if flagged then
        stdio.write(stdio.color("red"))
        print("Flagged")
    else
        stdio.write(stdio.color("green"))
        print("Not flagged")
    end

    stdio.write(stdio.color("reset"))
end
stdio.write(stdio.color("reset"))