fs = require('fs')
path = require('path')
rimraf = require('rimraf')
async = require('async')
Node = require('./node')

utils = require('./utils')

TEMP_DIRECTORY = process.env.TEMP or process.env.TMPDIR

exports.download = (options, dest, callback) ->
	node = new Node(options)
	finalOutputFile = path.join(dest, node.getBinaryName())

	async.waterfall([

		(callback) ->
			utils.downloadNodePackage(node, TEMP_DIRECTORY, callback)

		(nodePackage, callback) ->
			binaryPath = utils.getBinaryPath(nodePackage)
			fs.rename binaryPath, finalOutputFile, (error) ->
				return callback(error) if error?
				rimraf(binaryPath, callback)

		(callback) ->
			return callback(null, finalOutputFile)

	], callback)
