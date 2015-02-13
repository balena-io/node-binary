var Node, async, fs, path, settings, utils, _;

fs = require('fs');

path = require('path');

async = require('async');

_ = require('lodash-contrib');

Node = require('./node');

utils = require('./utils');

settings = require('./settings');

exports.download = function(options, dest, callback) {
  var finalOutputFile, node;
  if (dest == null) {
    throw new Error('Missing dest argument');
  }
  node = new Node(options);
  finalOutputFile = path.join(dest, node.getBinaryName());
  return async.waterfall([
    function(callback) {
      return utils.mkdirp(dest, _.unary(callback));
    }, function(callback) {
      return utils.downloadNodePackage(node, settings.tempDirectory, callback);
    }, function(nodePackage, callback) {
      var binaryPath;
      binaryPath = utils.getBinaryPath(nodePackage);
      return fs.rename(binaryPath, finalOutputFile, function(error) {
        if (error != null) {
          return callback(error);
        }
        return utils.removeDirectory(nodePackage, callback);
      });
    }, function(callback) {
      return callback(null, finalOutputFile);
    }
  ], callback);
};
