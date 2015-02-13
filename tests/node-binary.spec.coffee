path = require('path')
sinon = require('sinon')
_ = require('lodash-contrib')
chai = require('chai')
chai.use(require('sinon-chai'))
expect = chai.expect
fs = require('fs')
binary = require('../lib/node-binary')
settings = require('../lib/settings')
utils = require('../lib/utils')
Node = require('../lib/node')

describe 'Node Binary:', ->

	describe '.download()', ->

		it 'should throw an error if no options', ->
			expect ->
				binary.download(null, '.', _.noop)
			.to.throw('Missing options argument')

		it 'should throw an error if invalid options', ->
			expect ->
				binary.download([], '.', _.noop)
			.to.throw('Invalid options argument')

		it 'should throw an error if no dest', ->
			expect ->
				binary.download
					os: 'darwin'
					arch: 'x64'
					version: 'v0.12.0'
				, null, _.noop
			.to.throw('Missing dest argument')

	describe 'given a windows download', ->

		beforeEach ->
			settings.tempDirectory = '/tmp'

			@node = new Node
				arch: 'x64'
				os: 'win32'
				version: 'v0.12.0'

			@tempFile = path.join('tmp', 'node.exe')
			@destFile = path.join('dest', 'node-v0.12.0-win32-x64.exe')

			@utilsDownloadNodePackageStub = sinon.stub(utils, 'downloadNodePackage')
			@utilsDownloadNodePackageStub.yields(null, @tempFile)

			@fsRenameStub = sinon.stub(fs, 'rename')
			@fsRenameStub.yields(null)

			@utilsRemoveDirectory = sinon.stub(utils, 'removeDirectory')
			@utilsRemoveDirectory.yields(null)

			@utilsMkdirp = sinon.stub(utils, 'mkdirp')
			@utilsMkdirp.yields(null)

		afterEach ->
			@utilsDownloadNodePackageStub.restore()
			@fsRenameStub.restore()
			@utilsRemoveDirectory.restore()
			@utilsMkdirp.restore()

		it 'should complete the download in the correct place', (done) ->
			binary.download @node, 'dest', (error, binaryFile) =>
				expect(error).to.not.exist
				expect(binaryFile).to.equal(@destFile)
				expect(@utilsMkdirp).to.have.been.calledWith('dest')
				expect(@fsRenameStub).to.have.been.calledWith(@tempFile, @destFile)
				expect(@utilsRemoveDirectory).to.have.been.calledWith(@tempFile)
				done()

	describe 'given a darwin download', ->

		beforeEach ->
			settings.tempDirectory = '/tmp'

			@node = new Node
				arch: 'x64'
				os: 'darwin'
				version: 'v0.12.0'

			@tempFile = path.join('tmp', 'node-v0.12.0-darwin-x64')
			@destFile = path.join('dest', 'node-v0.12.0-darwin-x64')

			@utilsDownloadNodePackageStub = sinon.stub(utils, 'downloadNodePackage')
			@utilsDownloadNodePackageStub.yields(null, @tempFile)

			@fsRenameStub = sinon.stub(fs, 'rename')
			@fsRenameStub.yields(null)

			@utilsRemoveDirectory = sinon.stub(utils, 'removeDirectory')
			@utilsRemoveDirectory.yields(null)

			@utilsMkdirp = sinon.stub(utils, 'mkdirp')
			@utilsMkdirp.yields(null)

		afterEach ->
			@utilsDownloadNodePackageStub.restore()
			@fsRenameStub.restore()
			@utilsRemoveDirectory.restore()
			@utilsMkdirp.restore()

		it 'should complete the download in the correct place', (done) ->
			binary.download @node, 'dest', (error, binaryFile) =>
				expect(error).to.not.exist
				expect(binaryFile).to.equal(@destFile)
				expect(@utilsMkdirp).to.have.been.calledWith('dest')
				binPath = path.join(@tempFile, 'bin', 'node')
				expect(@fsRenameStub).to.have.been.calledWith(binPath, @destFile)
				expect(@utilsRemoveDirectory).to.have.been.calledWith(@tempFile)
				done()

	describe 'given a linux download', ->

		beforeEach ->
			settings.tempDirectory = '/tmp'

			@node = new Node
				arch: 'x64'
				os: 'linux'
				version: 'v0.12.0'

			@tempFile = path.join('tmp', 'node-v0.12.0-linux-x64')
			@destFile = path.join('dest', 'node-v0.12.0-linux-x64')

			@utilsDownloadNodePackageStub = sinon.stub(utils, 'downloadNodePackage')
			@utilsDownloadNodePackageStub.yields(null, @tempFile)

			@fsRenameStub = sinon.stub(fs, 'rename')
			@fsRenameStub.yields(null)

			@utilsRemoveDirectory = sinon.stub(utils, 'removeDirectory')
			@utilsRemoveDirectory.yields(null)

			@utilsMkdirp = sinon.stub(utils, 'mkdirp')
			@utilsMkdirp.yields(null)

		afterEach ->
			@utilsDownloadNodePackageStub.restore()
			@fsRenameStub.restore()
			@utilsRemoveDirectory.restore()
			@utilsMkdirp.restore()

		it 'should complete the download in the correct place', (done) ->
			binary.download @node, 'dest', (error, binaryFile) =>
				expect(error).to.not.exist
				expect(binaryFile).to.equal(@destFile)
				expect(@utilsMkdirp).to.have.been.calledWith('dest')
				binPath = path.join(@tempFile, 'bin', 'node')
				expect(@fsRenameStub).to.have.been.calledWith(binPath, @destFile)
				expect(@utilsRemoveDirectory).to.have.been.calledWith(@tempFile)
				done()

	describe 'given a sunos download', ->

		beforeEach ->
			settings.tempDirectory = '/tmp'

			@node = new Node
				arch: 'x64'
				os: 'sunos'
				version: 'v0.12.0'

			@tempFile = path.join('tmp', 'node-v0.12.0-sunos-x64')
			@destFile = path.join('dest', 'node-v0.12.0-sunos-x64')

			@utilsDownloadNodePackageStub = sinon.stub(utils, 'downloadNodePackage')
			@utilsDownloadNodePackageStub.yields(null, @tempFile)

			@fsRenameStub = sinon.stub(fs, 'rename')
			@fsRenameStub.yields(null)

			@utilsRemoveDirectory = sinon.stub(utils, 'removeDirectory')
			@utilsRemoveDirectory.yields(null)

			@utilsMkdirp = sinon.stub(utils, 'mkdirp')
			@utilsMkdirp.yields(null)

		afterEach ->
			@utilsDownloadNodePackageStub.restore()
			@fsRenameStub.restore()
			@utilsRemoveDirectory.restore()
			@utilsMkdirp.restore()

		it 'should complete the download in the correct place', (done) ->
			binary.download @node, 'dest', (error, binaryFile) =>
				expect(error).to.not.exist
				expect(binaryFile).to.equal(@destFile)
				expect(@utilsMkdirp).to.have.been.calledWith('dest')
				binPath = path.join(@tempFile, 'bin', 'node')
				expect(@fsRenameStub).to.have.been.calledWith(binPath, @destFile)
				expect(@utilsRemoveDirectory).to.have.been.calledWith(@tempFile)
				done()
