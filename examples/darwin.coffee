binary = require('../lib/node-binary')

destination = __dirname

console.log("Downloading node-v0.12.0-darwin-x64 binary to #{destination}")

binary.download
	os: 'darwin'
	arch: 'x64'
	version: 'v0.12.0'
, destination, (error, file) ->
	throw error if error?
	console.log("The binary was downloaded to #{file}")
