path = require('path')
_ = require('lodash-contrib')
_.str = require('underscore.string')
Download = require('download')

exports.stripExtension = (filePath, extension) ->

	if not filePath?
		throw new Error('Missing string argument')

	if not extension?
		throw new Error('Missing extension argument')

	return filePath if not _.str.endsWith(filePath, extension)
	return filePath.slice(0, filePath.length - extension.length)

# There is no need to test this function as it's
# just a wrapper of node-download.
# The purpose of this function is to be able to stub it
# on downloadNodePackage() tests.
exports.downloadAndExtract = (url, dest, callback) ->
	download = new Download(extract: true)
		.get(url)
		.dest(dest)

	download.run(_.unary(callback))

exports.downloadNodePackage = (node, dest, callback) ->
	exports.downloadAndExtract node.getDownloadUrl(), dest, (error) ->
		return callback(error) if error?

		output = path.join(dest, node.getDownloadOutput())
		output = exports.stripExtension(output, '.tar.gz')

		return callback(null, output)

exports.getBinaryPath = (nodePackage) ->
	return nodePackage if path.extname(nodePackage) is '.exe'
	return path.join(nodePackage, 'bin', 'node')
