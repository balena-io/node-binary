binary = require('../lib/node-binary')

console.log("Downloading node-v0.12.0-darwin-x64 binary to #{__dirname}")

binary.download
	os: 'darwin'
	arch: 'x64'
	version: 'v0.12.0'
, __dirname, (error, file) ->
	throw error if error?
	console.log("The binary was downloaded to #{file}")
