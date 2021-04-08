resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

description 'Quack Framework'

version '1.0'

server_scripts {
	"server/mysql-async.js",
	"reference/MySQL.lua",

	"server/main.lua",
	"shared/*.lua",

	"server/dependencies/*.lua",
	"server/classes/*.lua",
	"server/components/*.lua",
}

client_scripts {
	"client/main.lua",
	"client/login.lua",

	-- Load Component Dependencies
	"client/dependencies/*.lua",

	-- Load Shared Dependencies
	"shared/*.lua",

	-- Load Components (These build on top of base, and have no load order as they do not depend on each other)
	"client/components/*.lua",
}

ui_page 'html/index.html'

files({
    'html/index.html',

    "html/js/*.js",
    "html/css/*.css",
    'html/sounds/*.ogg',
    "html/images/**/*.*",

	"reference/cinit.lua",
	"reference/sinit.lua",
})

exports {
	"Target",
	"resetTalkerDistance",
	"setTempTalkerDistance",
	"setTalkerDistance",
	"isInstanced",
	"getInstance",
}

server_exports {
	"getIdentifiers",
}