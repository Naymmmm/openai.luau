--[[
    For use with Lune

    openai.luau
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

local Context = {}
Context.__index = Context

-- End variables.

function openai.new(Authorization: string, Model: string, SystemPrompt: string)
	local self = setmetatable({}, Context)
	self.Authorization = Authorization
	self.Model = Model
	if SystemPrompt ~= nil then
		self.SystemPrompt = SystemPrompt
	else
		self.SystemPrompt = "You are a completion created by the openai.luau API wrapper."
	end
	return self
end

function Context:Complete(Message: string)
	local response = net.request({
		url = "https://api.openai.com/v1/chat/completions",
		method = "POST",
		headers = { ["Content-Type"] = "application/json", ["Authorization"] = "Bearer " .. self.Authorization },
		body = net.jsonEncode({
			model = self.Model,
			messages = {
				{
					role = "system",
					content = self.SystemPrompt,
				},
				{
					role = "user",
					content = Message,
				},
			},
		}),
	})
	local messageresponse = net.jsonDecode(response.body)
	return messageresponse.message
end

return openai
