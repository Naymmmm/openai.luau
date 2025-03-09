<div align="center" id="toc">
<p>
	<img align="right" src="https://raw.githubusercontent.com/Naymmmm/openai.luau/v2/assets/logo.svg" width="256" alt="the-icon"/>
</p>
<div align="left">
<ul style="list-style: none;">
  <summary>
<h1>🤖 openai.luau</h1>
  </summary>
  </ul>
</div>
</div>

<a><img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/Naymmmm/openai.luau"></a>
<a><img alt="GitHub License" src="https://img.shields.io/github/license/Naymmmm/openai.luau"></a>
<a><img alt="Static Badge" src="https://img.shields.io/badge/coffee%20is-tasty-purple"></a>

openai.luau is a simple Luau library supporting Roblox & Lune!

## Table of Contents
- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Authentication](#authentication)
- [Creating a Context](#creating-a-context)
- [Using a Context](#using-a-context)

## Overview
openai.luau is a simple yet powerful Luau library for designed to interact with OpenAI's chat API. It is built with compatibility for both Roblox and Lune environments, providing an easy-to-use interface for developers to integrate OpenAI's conversational AI into their applications.

## Authentication
To authenticate with the API, you can either use the **Secret Store** feature in Roblox or plane strings. I recommend using an **enviroment** file for plain-text
authenication.

## Creating a Context
To create a context, used to interface with the API, pass
```lua
openai.New(ApiKey: string | Secret): RbxContext | ExternalContext
```
There is practically no difference between RbxContext and ExternalContext except for RbxContext using SecretStore for security reasons.

## Using a Context
To interact with a context, you can use the following
```lua
Context:Complete(Prompt: string, Model: string): result: string, success: boolean, statuscode: number
Context:Moderate(Input: string): result: boolean
```