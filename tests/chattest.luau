local openai = require("../src/openai")
local env = require("../env")
local stdio = require("@lune/stdio")
local context = openai.New(env.ApiKey, "You are GPT-3.5 Turbo, a powerful AI assistant")

stdio.write(stdio.color("purple"))
print("Chat Test")
stdio.write(stdio.color("reset"))

while true do
    local userMessage = stdio.prompt("text", "Enter a message to send to the chat model (or type 'exit' to quit):")
    
    if userMessage:lower() == "exit" then
        print("Exiting the chat...")
        break
    end

    local result = context:Complete(userMessage, "gpt-3.5-turbo")
    
    stdio.write(stdio.color("green"))
    print(result)
    stdio.write(stdio.color("reset"))
end
