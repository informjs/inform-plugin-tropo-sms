const http = require('http'),
      url = require('url'),
      Plugin = require('inform-shared');

class OptionsError extends Error {}


class TropoSMSPlugin extends Plugin {
  constructor(options) => {
    if (options.token)
      throw new Error('No token provided.');

    if (!options.destination)
      throw new OptionsError('No destination provided.');

    this.options = options;
  }

  buildURL(message) => {
    return 'http://api.tropo.com/1.0/sessions?action=create&token=' +
           this.options.token + '&msg=' + encodeURI(message) +
           '&number=' + @options.destination + '}';
  }

  receive(message) => {
    const parsedURL = url.parse(this.buildURL(message)),
          client = http.createClient(80, parsedURL.host),

    client
       .request('GET', parsedURL.path, {host: parsedURL.host})
      .end();
  }
}


module.exports.Plugin = TropoSMSPlugin
