var Download, mkdirp, path, rimraf, _;

path = require('path');

_ = require('lodash-contrib');

_.str = require('underscore.string');

Download = require('download');

rimraf = require('rimraf');

mkdirp = require('mkdirp');

exports.removeDirectory = function(directory, callback) {
  return rimraf(directory, callback);
};

exports.mkdirp = function(directory, callback) {
  return mkdirp(directory, callback);
};

exports.stripExtension = function(filePath, extension) {
  if (filePath == null) {
    throw new Error('Missing string argument');
  }
  if (extension == null) {
    throw new Error('Missing extension argument');
  }
  if (!_.str.endsWith(filePath, extension)) {
    return filePath;
  }
  return filePath.slice(0, filePath.length - extension.length);
};

exports.downloadAndExtract = function(url, dest, callback) {
  var download;
  download = new Download({
    extract: true
  }).get(url).dest(dest);
  return download.run(_.unary(callback));
};

exports.downloadNodePackage = function(node, dest, callback) {
  return exports.downloadAndExtract(node.getDownloadUrl(), dest, function(error) {
    var output;
    if (error != null) {
      return callback(error);
    }
    output = path.join(dest, node.getDownloadOutput());
    output = exports.stripExtension(output, '.tar.gz');
    return callback(null, output);
  });
};

exports.getBinaryPath = function(nodePackage) {
  if (path.extname(nodePackage) === '.exe') {
    return nodePackage;
  }
  return path.join(nodePackage, 'bin', 'node');
};
