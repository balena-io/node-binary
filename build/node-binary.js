var Node, TEMP_DIRECTORY, async, fs, path, rimraf, utils;

fs = require('fs');

path = require('path');

rimraf = require('rimraf');

async = require('async');

Node = require('./node');

utils = require('./utils');

TEMP_DIRECTORY = process.env.TEMP || process.env.TMPDIR;

exports.download = function(options, dest, callback) {
  var finalOutputFile, node;
  node = new Node(options);
  finalOutputFile = path.join(dest, node.getBinaryName());
  return async.waterfall([
    function(callback) {
      return utils.downloadNodePackage(node, TEMP_DIRECTORY, callback);
    }, function(nodePackage, callback) {
      var binaryPath;
      binaryPath = utils.getBinaryPath(nodePackage);
      return fs.rename(binaryPath, finalOutputFile, function(error) {
        if (error != null) {
          return callback(error);
        }
        return rimraf(binaryPath, callback);
      });
    }, function(callback) {
      return callback(null, finalOutputFile);
    }
  ], callback);
};
