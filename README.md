node-binary
---------

[![npm version](https://badge.fury.io/js/node-binary.svg)](http://badge.fury.io/js/node-binary)
[![dependencies](https://david-dm.org/resin-io/node-binary.png)](https://david-dm.org/resin-io/node-binary.png)
[![Build Status](https://travis-ci.org/resin-io/node-binary.svg?branch=master)](https://travis-ci.org/resin-io/node-binary)

Download node binaries for various platforms and architectures, easily.

```javascript
var binary = require('node-binary');

binary.download({
	os: 'darwin',
	arch: 'x64',
	version: 'v0.12.0'
}, '/opt/node', function(error, binaryPath) {
	if(error) throw error;

	console.log('The node binary for OS X x64 was downloaded to ' + binaryPath);
});
```

Installation
------------

Install `node-binary` by running:

```sh
$ npm install --save node-binary
```

CLI
---

`node-binary` provides a CLI version as well. Install it by running:

```sh
$ npm install -g node-binary
```

You can now download node binaries like this:

```sh
$ node-binary download v0.12.0 ~/Downloads --arch x64 --os darwin
```

Documentation
-------------

### binary.download(Object options, String dest, Function callback)

Download a nodejs binary to a certain location.

#### options

- `os` is the operating system to download node for.

This module curently supports `darwin`, `win32`, `linux` and `sunos`.

- `arch` is the architecture to download node for.

This module curently supports `x64` and `x86`.

- `version` is the node version to download.

It can be a string such as `v0.12.0` or simply `0.12.0`.

#### dest

The directory to download the binary to.

The binary will automatically be renamed to `node-<version>-<os>-<arch>[.exe]`.

#### callback(error, binaryPath)

The callback will be called with a possible error, or with the absolute path to the downloaded binary.

Tests
-----

Run the test suite by doing:

```sh
$ gulp test
```

TODO
----

- [  ] Implement a way to get the state of the download, to make use of a progress bar, etc.
- [  ] Add executable mode to resulting binaries on UNIX. 

Contribute
----------

- Issue Tracker: [github.com/resin-io/node-binary/issues](https://github.com/resin-io/node-binary/issues)
- Source Code: [github.com/resin-io/node-binary](https://github.com/resin-io/node-binary)

Before submitting a PR, please make sure that you include tests, and that [coffeelint](http://www.coffeelint.org/) runs without any warning:

```sh
$ gulp lint
```

ChangeLog
---------

### v1.1.0

- Improve error messages.
- Prevent temporary directory from being undefined.

### v1.0.1

Set mode to 755 for the downloaded binary.

Support
-------

If you're having any problem, please [raise an issue](https://github.com/resin-io/node-binary/issues/new) on GitHub.

License
-------

The project is licensed under the MIT license.
