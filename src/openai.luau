--[=[
	@class openai.luau
	(C) darwin/naymmm 2025
	Licensed under GNU-GPlv3

	An API wrapper for OpenAI's GPT-3 API, written in Luau.
	You can use this to interact with the API and get completions.
]=]

openai = {}

-- Types
type Message = { role: string, content: string }

type RbxContext = {
    ApiKey: Secret,
    Messages: {Message},
    Complete: (self: RbxContext, prompt: string, system: string) -> (string, boolean)
}

type ExternalContext = {
    ApiKey: string,
    Messages: {Message},
    Complete: (self: ExternalContext, prompt: string, system: string) -> (string, boolean)
}


--[=[
	This is a constructor for new contexts, to interact with the API

	@param apiKey string | Secret -- API key for the OpenAI API or secret for Roblox
	@return 
]=]
function openai.New(apiKey: string | Secret)
	-- Checking if it's Roblox
	local isRoblox = typeof(game) == "Instance" and game.ClassName == "DataModel"

	if isRoblox then
	end
end

return openai
