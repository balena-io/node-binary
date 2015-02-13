capitano = require('capitano')
binary = require('./node-binary')

capitano.command
	signature: '*'
	action: ->
		console.log("Usage: #{process.argv[0]} download <version> <output> --arch <arch> --os <os>")

capitano.command
	signature: 'download <version> <output>'
	description: 'download nodejs binaries'
	options: [
		{
			signature: 'os'
			parameter: 'os'
			description: 'os'
			alias: 's'
			required: 'You have to specify an os'
		}
		{
			signature: 'arch'
			parameter: 'arch'
			description: 'arch'
			alias: 'a'
			required: 'You have to specify an arch'
		}
	]
	action: (params, options, done) ->
		console.info('Downloading node...')
		binary.download
			os: options.os
			arch: options.arch
			version: params.version
		, params.output, (error, binaryPath) ->
			return done(error) if error?
			console.info("Node downloaded in: #{binaryPath}")
			done()

capitano.run process.argv, (error) ->
	return if not error?
	console.error(error.message)
	process.exit(1)
