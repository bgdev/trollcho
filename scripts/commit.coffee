# Description:
# 	Random commit messages.
#
# Dependencies:
# 	'jsdom': ''
# 	'jquery': ''
#
# Configuration:
# 	None
#
# Commands:
# 	trollcho commit - Shows a commit message
#
# Author: Yordan Ivanov

jsdom = require('jsdom').jsdom

module.exports = (robot) ->
	robot.respond /commit/i, (msg) ->
		msg
			.http('http://whatthecommit.com/')
			.get() (error, response, body) ->
				window = (jsdom body, null,
				features:
					FetchExternalResources: false
					ProcessExternalResources: false
					MutationEvents: false
					QuerySelector: false
				).createWindow()

				$ = require('jquery').create(window)
				message = $.trim $('#content > p:first').text();

				if message
					msg.send message
				else
					msg.send 'No commit message available'