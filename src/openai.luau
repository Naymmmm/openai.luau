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
    Complete: (self: RbxContext, prompt: string, model: string) -> (string, boolean, number),
	Moderate: (self: ExternalContext, input: string) -> (boolean)
}

type ExternalContext = {
    ApiKey: string,
    Messages: {Message},
	SystemPrompt: string,
    Complete: (self: ExternalContext, prompt: string, model: string) -> (string, boolean, number),
	Moderate: (self: ExternalContext, input: string) -> (boolean)
}

--[=[
	This is a helper function for completions and should not be used directly

	@param Context RbxContext | ExternalContext -- The context to interact with
	@param Prompt string -- The prompt to complete
	@return string, boolean, code -- The completion, whether it was successful, and the status code
]=]
local function HelperComplete(Context: RbxContext | ExternalContext, Prompt: string, Model: string)
	local isRbxContext = typeof(Context.ApiKey) == "Secret"
	table.insert(Context.Messages, { role = "user", content = Prompt })
	
	if isRbxContext then
		local HttpService = game:GetService("HttpService")
		local data = HttpService:JSONEncode({
			model = Model,
			messages = Context.Messages,
		})
		local response = HttpService:PostAsync("https://api.openai.com/v1/chat/completions", data, Enum.HttpContentType.ApplicationJson, false, {
			["Content-Type"] = "application/json",
			["Authorization"] = Context.ApiKey:AddPrefix("Bearer ")
		})
		local decoded = HttpService:JSONDecode(response)

		print(decoded)
		return decoded.body.choices[1].message.content
	else
		local net = require("@lune/net")
		local response = net.request({
			url = "https://api.openai.com/v1/chat/completions",
			method = "POST",
			headers = { 
				["Content-Type"] = "application/json",
				["Authorization"] = "Bearer "..Context.ApiKey
			},
			body = net.jsonEncode({
				model = Model,
				messages = Context.Messages,
			})
		})

		return net.jsonDecode(response.body).choices[1].message.content, response.ok, response.statusCode
	end
end

local function HelperModerate(Context: RbxContext | ExternalContext, Input: string)
	local isRbxContext = typeof(Context.ApiKey) == "Secret"

	if isRbxContext then
		local HttpService = game:GetService("HttpService")
		local data = HttpService:JSONEncode({
			input = Input
		})
		local response = HttpService:PostAsync("https://api.openai.com/v1/moderations", data, Enum.HttpContentType.ApplicationJson, false, {
			["Content-Type"] = "application/json",
			["Authorization"] = Context.ApiKey:AddPrefix("Bearer ")
		})
		local decoded = HttpService:JSONDecode(response)

		print(decoded)
		return decoded.body.results[1].flagged  
	else
		local net = require("@lune/net")
		local response = net.request({
			url = "https://api.openai.com/v1/chat/moderations",
			method = "POST",
			headers = { 
				["Content-Type"] = "application/json",
				["Authorization"] = "Bearer "..Context.ApiKey
			},
			body = net.jsonEncode({
				input = Input
			})
		})

		return net.jsonDecode(response.body).results[1].flagged
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
        Messages = {
			{ role = "system", content = SystemPrompt }
		},
        SystemPrompt = SystemPrompt,
        Complete = function(self, prompt: string, model: string)
            return HelperComplete(self, prompt, model)
        end,
		Moderate = function(self, input: string)
			return HelperModerate(self, input)
		end
    }

    return isRoblox and (Context :: RbxContext) or (Context :: ExternalContext)
end

return openai
