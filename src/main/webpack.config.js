const path = require('path');

module.exports = {
  entry: './src/main/index.js', // Adjust if needed
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'target/classes/static/built'),
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