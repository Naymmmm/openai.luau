--[[
    For use with Roblox

    openai.luau (Roblox Port)
    Copyright (C) 2024, naymmmiscool

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

]]

openai = {}

-- Begin variables section.

local HttpService = game:GetService("HttpService")

local Context = {}
Context.__index = Context

-- End variables.

-- Function to create a new context.
function openai.new(Model: string, SystemPrompt: string)
	local self = setmetatable({}, Context)
	self.Model = Model -- Assign the model.
	if SystemPrompt ~= nil then
		self.SystemPrompt = SystemPrompt -- Yuh.
	else
		self.SystemPrompt = "You are a completion created by the openai.luau API wrapper." -- I think... uhh.
	end
	return self
end

-- Completions function, I think.
function Context:Complete(Message: string, SecretKey: string) -- You need a message, duh.
	local lsecret = HttpService:GetSecret(SecretKey)
	local prefixedsecret = lsecret:AddPrefix("Bearer ")
	local oneheader = { ["Authorization"] = prefixedsecret }
	local body = HttpService:JSONEncode({ -- Encode the thing.
		model = self.Model,
		messages = {
			{
				role = "system", -- System prompt.
				content = self.SystemPrompt,
			},
			{
				role = "user", -- User message.
				content = Message,
			},
		},
	})
	local response = HttpService:PostAsync(
		"https://api.openai.com/v1/chat/completions",
		body,
		Enum.HttpContentType.ApplicationJson,
		false,
		oneheader
	)
	local messageresponse = HttpService:JSONDecode(response)
	return messageresponse.choices[1].message.content
end

return openai
