fs = require('fs')
path = require('path')
async = require('async')
_ = require('lodash-contrib')

Node = require('./node')
utils = require('./utils')
settings = require('./settings')

exports.download = (options, dest, callback) ->

	if not dest?
		throw new Error('Missing dest argument')

	node = new Node(options)
	finalOutputFile = path.join(dest, node.getBinaryName())

	async.waterfall([

		(callback) ->
			utils.mkdirp(dest, _.unary(callback))

		(callback) ->
			utils.downloadNodePackage(node, settings.tempDirectory, callback)

		(nodePackage, callback) ->
			binaryPath = utils.getBinaryPath(nodePackage)
			fs.rename binaryPath, finalOutputFile, (error) ->
				return callback(error) if error?
				utils.removeDirectory(nodePackage, callback)

		(callback) ->
			return callback(null, finalOutputFile)

	], callback)
