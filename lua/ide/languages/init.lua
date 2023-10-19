local languages = {}

languages["lua"] = require("ide.languages.lua")
languages["bash"] = require("ide.languages.bash")
languages["python"] = require("ide.languages.python")
languages["git"] = require("ide.languages.git")
languages["cpp"] = require("ide.languages.cpp")
languages["docker"] = require("ide.languages.docker")
languages["json"] = require("ide.languages.json")
languages["markdown"] = require("ide.languages.markdown")
languages["sql"] = require("ide.languages.sql")
languages["yaml"] = require("ide.languages.yaml")
languages["typescript"] = require("ide.languages.typescript")
languages["helm"] = require("ide.languages.helm")
languages["jq"] = require("ide.languages.jq")
languages["xml"] = require("ide.languages.xml")

return languages
