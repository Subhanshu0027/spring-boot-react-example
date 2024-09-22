const path = require('path');

module.exports = {
  entry: './src/index.js', // Adjust this to point to your entry file
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'target/classes/static/built'), // Adjust as needed
  },
  mode: 'production',
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
    ],
  },
};