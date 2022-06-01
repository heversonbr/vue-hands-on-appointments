// vue.config.js is an optional config file that will be automatically loaded by @vue/cli-service 
// if it's present in your project root (next to package.json)
// The file should export an object containing options:
module.exports = {
    publicPath: process.env.NODE_ENV === 'production' ? '/apps/appointments' : '/'
  }