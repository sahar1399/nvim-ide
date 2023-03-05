local languages = {}

languages["lua"] = require("ide.languages.lua")
languages["python"] = require("ide.languages.python")
languages["git"] = require("ide.languages.git")

return languages
