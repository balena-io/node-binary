chai = require('chai')
expect = chai.expect
Node = require('../lib/node')

describe 'Node:', ->

	describe '#constructor()', ->

		it 'should throw an error if no options', ->
			expect ->
				new Node()
			.to.throw('Missing options argument')

		it 'should throw an error if options is not an object', ->
			expect ->
				new Node([])
			.to.throw('Invalid options argument')

		it 'should throw an error if no arch', ->
			expect ->
				new Node
					os: 'darwin'
					version: 'v0.12.0'
			.to.throw('Missing arch option')

		it 'should throw an error if arch is not supported', ->
			expect ->
				new Node
					arch: 'arm'
					os: 'darwin'
					version: 'v0.12.0'
			.to.throw('Unsupported arch: arm')

		it 'should throw an error if no os', ->
			expect ->
				new Node
					arch: 'x86'
					version: 'v0.12.0'
			.to.throw('Missing os option')

		it 'should throw an error if os is not supported', ->
			expect ->
				new Node
					arch: 'x86'
					os: 'freebsd'
					version: 'v0.12.0'
			.to.throw('Unsupported os: freebsd')

		it 'should throw an error if no version', ->
			expect ->
				new Node
					arch: 'x86'
					os: 'darwin'
			.to.throw('Missing version option')

		it 'should throw an error if version is invalid', ->
			expect ->
				new Node
					arch: 'x86'
					os: 'darwin'
					version: 'asdf'
			.to.throw('Invalid version option: asdf')

		describe 'if version is missing v prefix', ->

			it 'should add the prefix', ->
				node = new Node
					arch: 'x86'
					os: 'darwin'
					version: '0.12.0'

				expect(node.version).to.equal('v0.12.0')

		it 'should expose arch to the instance', ->
			node = new Node
				arch: 'x86'
				os: 'darwin'
				version: 'v0.12.0'

			expect(node.arch).to.equal('x86')

		it 'should expose os to the instance', ->
			node = new Node
				arch: 'x86'
				os: 'darwin'
				version: 'v0.12.0'

			expect(node.os).to.equal('darwin')

		it 'should expose version to the instance', ->
			node = new Node
				arch: 'x86'
				os: 'darwin'
				version: 'v0.12.0'

			expect(node.version).to.equal('v0.12.0')

	describe '#getDownloadUrl()', ->

		describe 'given win32 os', ->

			describe 'given x86 arch', ->

				beforeEach ->
					@node = new Node
						arch: 'x86'
						os: 'win32'
						version: 'v0.12.0'

				it 'should give the correct url', ->
					url = @node.getDownloadUrl()
					expect(url).to.equal('http://nodejs.org/dist/v0.12.0/node.exe')

			describe 'given x64 arch', ->
				beforeEach ->
					@node = new Node
						arch: 'x64'
						os: 'win32'
						version: 'v0.12.0'

				it 'should give the correct url', ->
					url = @node.getDownloadUrl()
					expectedUrl = 'http://nodejs.org/dist/v0.12.0/x64/node.exe'
					expect(url).to.equal(expectedUrl)


		describe 'given darwin os', ->

			beforeEach ->
				@node = new Node
					arch: 'x64'
					os: 'darwin'
					version: 'v0.12.0'

			it 'should give the correct url', ->
				url = @node.getDownloadUrl()
				expectedUrl = 'http://nodejs.org/dist/v0.12.0/node-v0.12.0-darwin-x64.tar.gz'
				expect(url).to.equal(expectedUrl)

		describe 'given linux os', ->

			beforeEach ->
				@node = new Node
					arch: 'x64'
					os: 'linux'
					version: 'v0.12.0'

			it 'should give the correct url', ->
				url = @node.getDownloadUrl()
				expectedUrl = 'http://nodejs.org/dist/v0.12.0/node-v0.12.0-linux-x64.tar.gz'
				expect(url).to.equal(expectedUrl)

		describe 'given sunos os', ->

			beforeEach ->
				@node = new Node
					arch: 'x64'
					os: 'sunos'
					version: 'v0.12.0'

			it 'should give the correct url', ->
				url = @node.getDownloadUrl()
				expectedUrl = 'http://nodejs.org/dist/v0.12.0/node-v0.12.0-sunos-x64.tar.gz'
				expect(url).to.equal(expectedUrl)

	describe '#getPackageName()', ->

		it 'should give the correct package name', ->
			node = new Node
				arch: 'x86'
				os: 'darwin'
				version: 'v0.12.0'

			expect(node.getPackageName()).to.equal('node-v0.12.0-darwin-x86')

	describe '#getBinaryName', ->

		describe 'given win32 os', ->

			beforeEach ->
				@node = new Node
					arch: 'x64'
					os: 'win32'
					version: 'v0.12.0'

			it 'should return the correct binary name', ->
				expect(@node.getBinaryName()).to.equal('node-v0.12.0-win32-x64.exe')

		describe 'given darwin os', ->

			beforeEach ->
				@node = new Node
					arch: 'x64'
					os: 'darwin'
					version: 'v0.12.0'

			it 'should return the correct binary name', ->
				expect(@node.getBinaryName()).to.equal('node-v0.12.0-darwin-x64')

		describe 'given linux os', ->

			beforeEach ->
				@node = new Node
					arch: 'x64'
					os: 'linux'
					version: 'v0.12.0'

			it 'should return the correct binary name', ->
				expect(@node.getBinaryName()).to.equal('node-v0.12.0-linux-x64')

		describe 'given sunos os', ->

			beforeEach ->
				@node = new Node
					arch: 'x64'
					os: 'sunos'
					version: 'v0.12.0'

			it 'should return the correct binary name', ->
				expect(@node.getBinaryName()).to.equal('node-v0.12.0-sunos-x64')

	describe '#getDownloadOutput()', ->

		describe 'given win32 os', ->

			describe 'given x86 arch', ->

				beforeEach ->
					@node = new Node
						arch: 'x86'
						os: 'win32'
						version: 'v0.12.0'

				it 'should return node.exe', ->
					expect(@node.getDownloadOutput()).to.equal('node.exe')

			describe 'given x64 arch', ->

				beforeEach ->
					@node = new Node
						arch: 'x64'
						os: 'win32'
						version: 'v0.12.0'

				it 'should return node.exe', ->
					expect(@node.getDownloadOutput()).to.equal('node.exe')

		describe 'given darwin os', ->

			beforeEach ->
				@node = new Node
					arch: 'x64'
					os: 'darwin'
					version: 'v0.12.0'

			it 'should give the correct output', ->
				output = @node.getDownloadOutput()
				expect(output).to.equal('node-v0.12.0-darwin-x64.tar.gz')

		describe 'given linux os', ->

			beforeEach ->
				@node = new Node
					arch: 'x64'
					os: 'linux'
					version: 'v0.12.0'

			it 'should give the correct output', ->
				output = @node.getDownloadOutput()
				expect(output).to.equal('node-v0.12.0-linux-x64.tar.gz')

		describe 'given sunos os', ->

			beforeEach ->
				@node = new Node
					arch: 'x64'
					os: 'sunos'
					version: 'v0.12.0'

			it 'should give the correct output', ->
				output = @node.getDownloadOutput()
				expect(output).to.equal('node-v0.12.0-sunos-x64.tar.gz')
