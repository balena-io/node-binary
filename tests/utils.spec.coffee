sinon = require('sinon')
chai = require('chai')
chai.use(require('sinon-chai'))
expect = chai.expect
path = require('path')
utils = require('../lib/utils')
Node = require('../lib/node')

describe 'Utils:', ->

	describe '.getBinaryPath()', ->

		describe 'given a unix node package', ->

			beforeEach ->
				@nodePackage = path.join('foo', 'bar', 'node-v0.12.0-darwin-x64')

			it 'should return the path to the binary', ->
				expectedPath = path.join(@nodePackage, 'bin', 'node')
				expect(utils.getBinaryPath(@nodePackage)).to.equal(expectedPath)

		describe 'given a windows node package', ->

			beforeEach ->
				@nodePackage = path.join('foo', 'bar', 'node.exe')

			it 'should return the same package', ->
				expect(utils.getBinaryPath(@nodePackage)).to.equal(@nodePackage)

	describe '.downloadNodePackage()', ->

		describe 'given an error', ->

			beforeEach ->
				@utilsDownloadAndExtractStub = sinon.stub(utils, 'downloadAndExtract')
				@utilsDownloadAndExtractStub.yields(new Error('Download Error'))

			afterEach ->
				@utilsDownloadAndExtractStub.restore()

			it 'should get the error', (done) ->
				node = new Node
					arch: 'x64'
					os: 'darwin'
					version: 'v0.12.0'

				utils.downloadNodePackage node, '.', (error, file) ->
					expect(error).to.be.an.instanceof(Error)
					expect(error.message).to.equal('Download Error')
					expect(file).to.not.exist
					done()

		describe 'given no errors', ->

			beforeEach ->
				@utilsDownloadAndExtractStub = sinon.stub(utils, 'downloadAndExtract')
				@utilsDownloadAndExtractStub.yields(null)

			afterEach ->
				@utilsDownloadAndExtractStub.restore()

			describe 'given win32 os', ->

				beforeEach ->
					@node = new Node
						arch: 'x64'
						os: 'win32'
						version: 'v0.12.0'

				it 'should get the downloaded package path', (done) ->
					utils.downloadNodePackage @node, '.', (error, file) ->
						expect(error).to.not.exist
						expectedPath = path.join('.', 'node.exe')
						expect(file).to.equal(expectedPath)
						done()

			describe 'given darwin os', ->

				beforeEach ->
					@node = new Node
						arch: 'x64'
						os: 'darwin'
						version: 'v0.12.0'

				it 'should get the downloaded package path', (done) ->
					utils.downloadNodePackage @node, '.', (error, file) ->
						expect(error).to.not.exist
						expectedPath = path.join('.', 'node-v0.12.0-darwin-x64')
						expect(file).to.equal(expectedPath)
						done()

			describe 'given linux os', ->

				beforeEach ->
					@node = new Node
						arch: 'x64'
						os: 'linux'
						version: 'v0.12.0'

				it 'should get the downloaded package path', (done) ->
					utils.downloadNodePackage @node, '.', (error, file) ->
						expect(error).to.not.exist
						expectedPath = path.join('.', 'node-v0.12.0-linux-x64')
						expect(file).to.equal(expectedPath)
						done()

			describe 'given sunos os', ->

				beforeEach ->
					@node = new Node
						arch: 'x64'
						os: 'sunos'
						version: 'v0.12.0'

				it 'should get the downloaded package path', (done) ->
					utils.downloadNodePackage @node, '.', (error, file) ->
						expect(error).to.not.exist
						expectedPath = path.join('.', 'node-v0.12.0-sunos-x64')
						expect(file).to.equal(expectedPath)
						done()

	describe '.stripExtension()', ->

		it 'should throw an error if no string', ->
			expect ->
				utils.stripExtension(null, '.png')
			.to.throw('Missing string argument')

		it 'should throw an error if no extension', ->
			expect ->
				utils.stripExtension('foo')
			.to.throw('Missing extension argument')

		it 'should strip simple extensions', ->
			expect(utils.stripExtension('hello.png', '.png')).to.equal('hello')

		it 'should strip multiple extensions', ->
			expect(utils.stripExtension('hello.tar.gz', '.tar.gz')).to.equal('hello')

		it 'should return the same string if the extension is not matched', ->
			expect(utils.stripExtension('hello.tar.gz', '.png')).to.equal('hello.tar.gz')

		describe 'given unix os', ->

			describe 'given absolute unix paths', ->

				it 'should strip simple extensions', ->
					expect(utils.stripExtension('/foo/bar/hello.png', '.png')).to.equal('/foo/bar/hello')

				it 'should strip multiple extensions', ->
					expect(utils.stripExtension('/foo/bar/hello.tar.gz', '.tar.gz')).to.equal('/foo/bar/hello')

				it 'should handle paths with a dot', ->
					expect(utils.stripExtension('/foo.bar/hello.png', '.png')).to.equal('/foo.bar/hello')

			describe 'given relative unix paths', ->

				it 'should strip simple extensions', ->
					expect(utils.stripExtension('./foo/bar/hello.png', '.png')).to.equal('./foo/bar/hello')

				it 'should strip multiple extensions', ->
					expect(utils.stripExtension('./foo/bar/hello.tar.gz', '.tar.gz')).to.equal('./foo/bar/hello')

				it 'should handle paths with a dot', ->
					expect(utils.stripExtension('./foo.bar/hello.png', '.png')).to.equal('./foo.bar/hello')

		describe 'given windows os', ->

			describe 'given absolute windows paths', ->

				it 'should strip simple extensions', ->
					expect(utils.stripExtension('C:\\foo\\bar\\hello.png', '.png')).to.equal('C:\\foo\\bar\\hello')

				it 'should strip multiple extensions', ->
					expect(utils.stripExtension('C:\\foo\\bar\\hello.tar.gz', '.tar.gz')).to.equal('C:\\foo\\bar\\hello')

				it 'should handle paths with a dot', ->
					expect(utils.stripExtension('C:\\foo.bar\\hello.png', '.png')).to.equal('C:\\foo.bar\\hello')

			describe 'given relative windows paths', ->

				it 'should strip simple extensions', ->
					expect(utils.stripExtension('.\\foo\\bar\\hello.png', '.png')).to.equal('.\\foo\\bar\\hello')

				it 'should strip multiple extensions', ->
					expect(utils.stripExtension('.\\foo\\bar\\hello.tar.gz', '.tar.gz')).to.equal('.\\foo\\bar\\hello')

				it 'should handle paths with a dot', ->
					expect(utils.stripExtension('.\\foo.bar\\hello.png', '.png')).to.equal('.\\foo.bar\\hello')
