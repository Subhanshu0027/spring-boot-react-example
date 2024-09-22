const path = require('path');

module.exports = {
  entry: './src/main/index.js',
  output: {
    path: path.resolve(__dirname, 'target/classes/static/built'),
    filename: 'bundle.js',
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
    ],
  },
  resolve: {
    extensions: ['.js', '.jsx'],
  },
};