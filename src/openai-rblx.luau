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

local net = require("@lune/net")
local HttpService = require(game:GetService("HttpService"))

local Context = {}
Context.__index = Context

-- End variables.

-- Function to create a new context.
function openai.new(Authorization: string, Model: string, SystemPrompt: string)
	local self = setmetatable({}, Context)
	self.Authorization = Authorization -- Assign the token to the context (probably)
	self.Model = Model -- Assign the model.
	if SystemPrompt ~= nil then
		self.SystemPrompt = SystemPrompt -- Yuh.
	else
		self.SystemPrompt = "You are a completion created by the openai.luau API wrapper." -- I think... uhh.
	end
	return self
end

-- Completions function, I think.
function Context:Complete(Message: string) -- You need a message, duh.
	local response = net.request({ -- Create a new request, because we can.
		url = "https://api.openai.com/v1/chat/completions",
		method = "POST", -- Post it.
		headers = { ["Content-Type"] = "application/json", ["Authorization"] = "Bearer " .. self.Authorization },
		body = net.jsonEncode({ -- Encode the thing.
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
		}),
	})
	local messageresponse = net.jsonDecode(response.body)
	local statuscode = net.jsonDecode(response.statusCode)
	if statuscode ~= 200 then
		warn("API returned " .. statuscode .. "!")
	else
		return messageresponse.choices[1].message.content
	end
end

return openai
