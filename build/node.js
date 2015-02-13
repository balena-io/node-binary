var Node, path, settings, _;

_ = require('lodash-contrib');

path = require('path');

settings = require('./settings');

module.exports = Node = (function() {
  function Node(options) {
    if (options == null) {
      throw new Error('Missing options argument');
    }
    if (!_.isObject(options) || _.isArray(options)) {
      throw new Error('Invalid options argument');
    }
    if (options.arch == null) {
      throw new Error('Missing arch option');
    }
    if (!_.contains(settings.support.arch, options.arch)) {
      throw new Error("Unsupported arch: " + options.arch);
    }
    if (options.os == null) {
      throw new Error('Missing os option');
    }
    if (!_.contains(settings.support.os, options.os)) {
      throw new Error("Unsupported os: " + options.os);
    }
    if (options.version == null) {
      throw new Error('Missing version option');
    }
    if (!/[\d]+\.[\d]+\.[\d]+/.test(options.version)) {
      throw new Error("Invalid version option: " + options.version);
    }
    if (_.first(options.version) !== 'v') {
      options.version = 'v' + options.version;
    }
    _.extend(this, options);
  }

  Node.prototype.getDownloadUrl = function() {
    var osUrls, url;
    osUrls = settings.urls[this.os];
    url = osUrls[this.arch] || osUrls.universal;
    return _.template(url, this);
  };

  Node.prototype.getDownloadOutput = function() {
    return path.basename(this.getDownloadUrl());
  };

  Node.prototype.getPackageName = function() {
    return _.template(settings.packageName, this);
  };

  Node.prototype.getBinaryName = function() {
    var result;
    result = this.getPackageName();
    if (this.os === 'win32') {
      result += '.exe';
    }
    return result;
  };

  return Node;

})();
