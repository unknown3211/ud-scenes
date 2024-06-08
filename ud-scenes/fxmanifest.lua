fx_version "cerulean"
game 'gta5'
description "Onx Inspired Scenes"
author "UnKnownJohn"
version '1.0.0'

lua54 'yes'

ui_page 'web/build/index.html'

client_script "client/**/*"
server_script "server/**/*"

files {
	'web/build/index.html',
	'web/build/**/*',
}