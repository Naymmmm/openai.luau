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
	SystemPrompt: string,
    Complete: (self: RbxContext, prompt: string, system: string) -> (string, boolean)
}

type ExternalContext = {
    ApiKey: string,
    Messages: {Message},
	SystemPrompt: string,
    Complete: (self: ExternalContext, prompt: string, system: string) -> (string, boolean)
}

--[=[
	This is a helper function for completions and should not be used directly

	@param Context RbxContext | ExternalContext -- The context to interact with
	@param Prompt string -- The prompt to complete
	@return string, boolean, code -- The completion, whether it was successful, and the status code
]=]
local function HelperComplete(Context: RbxContext | ExternalContext, Prompt: string)
	local isRbxContext = typeof(Context.ApiKey) == "Secret"
	
	if isRbxContext then
		local HttpService = game:GetService("HttpService")
	else
		local net = require("@lune/net")
		local response = net.request({
			url = "https://dummyjson.com/products/add",
			method = "POST",
			headers = { ["Content-Type"] = "application/json" },
			body = net.jsonEncode({
				title = "Cool Pencil",
			})
		})
	end
end

--[=[
	This is a constructor for new contexts, to interact with the API

	@param ApiKey string | Secret -- API key for the OpenAI API or secret for Roblox
	@param SystemPrompt string -- The system prompt to use for completions
	@return Context RbxContext | ExternalContext -- The context to interact with
]=]
function openai.New(ApiKey: string | Secret, SystemPrompt: string)
    local isRoblox = typeof(game) == "Instance" and game.ClassName == "DataModel"

    local Context = {
        ApiKey = ApiKey,
        Messages = {},
        SystemPrompt = SystemPrompt,
        Complete = function(self, prompt: string)
            return HelperComplete(self, prompt) -- Make sure HelperComplete exists
        end
    }

    return isRoblox and (Context :: RbxContext) or (Context :: ExternalContext)
end

return openai
