var binary, capitano;

capitano = require('capitano');

binary = require('./node-binary');

capitano.command({
  signature: '*',
  action: function() {
    return console.log("Usage: " + process.argv[0] + " download <version> <output> --arch <arch> --os <os>");
  }
});

capitano.command({
  signature: 'download <version> <output>',
  description: 'download nodejs binaries',
  options: [
    {
      signature: 'os',
      parameter: 'os',
      description: 'os',
      alias: 'o',
      required: 'You have to specify an os'
    }, {
      signature: 'arch',
      parameter: 'arch',
      description: 'arch',
      alias: 'a',
      required: 'You have to specify an arch'
    }
  ],
  action: function(params, options, done) {
    console.info("Downloading node-" + params.version + "-" + options.os + "-" + options.arch + " to " + params.output);
    return binary.download({
      os: options.os,
      arch: options.arch,
      version: params.version
    }, params.output, function(error, binaryPath) {
      if (error != null) {
        return done(error);
      }
      console.info("Node downloaded in: " + binaryPath);
      return done();
    });
  }
});

capitano.run(process.argv, function(error) {
  if (error == null) {
    return;
  }
  console.error(error.message);
  return process.exit(1);
});
