_ = require('lodash-contrib')

settings =

	packageName: 'node-<%= version %>-<%= os %>-<%= arch %>'

	tempDirectory: process.env.TEMP or process.env.TMPDIR or process.env.TMP or '/tmp'

baseUrl = 'http://nodejs.org/dist/<%= version %>'
unixUrl = "#{baseUrl}/node-<%= version %>-<%= os %>-<%= arch %>.tar.gz"

settings.urls =

	win32:
		x86: "#{baseUrl}/node.exe"
		universal: "#{baseUrl}/<%= arch %>/node.exe"

	linux:
		universal: unixUrl

	darwin:
		universal: unixUrl

	sunos:
		universal: unixUrl

settings.support =
	os: _.keys(settings.urls)

	arch: [
		'x86'
		'x64'
	]

module.exports = settings
