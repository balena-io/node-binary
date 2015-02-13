_ = require('lodash-contrib')
path = require('path')

settings = require('./settings')

module.exports = class Node
	constructor: (options) ->
		if not options?
			throw new Error('Missing options argument')

		if not _.isObject(options) or _.isArray(options)
			throw new Error('Invalid options argument')

		if not options.arch?
			throw new Error('Missing arch option')

		if not _.contains(settings.support.arch, options.arch)
			throw new Error("Unsupported arch: #{options.arch}")

		if not options.os?
			throw new Error('Missing os option')

		if not _.contains(settings.support.os, options.os)
			throw new Error("Unsupported os: #{options.os}")

		if not options.version?
			throw new Error('Missing version option')

		# TODO: Validate version with a regexp
		if not /[\d]+\.[\d]+\.[\d]+/.test(options.version)
			throw new Error("Invalid version option: #{options.version}")

		if _.first(options.version) isnt 'v'
			options.version = 'v' + options.version

		_.extend(this, options)

	getDownloadUrl: ->
		osUrls = settings.urls[@os]
		url = osUrls[@arch] or osUrls.universal
		return _.template(url, this)

	getDownloadOutput: ->
		return path.basename(@getDownloadUrl())

	getPackageName: ->
		return _.template(settings.packageName, this)

	getBinaryName: ->
		result = @getPackageName()
		result += '.exe' if @os is 'win32'
		return result
