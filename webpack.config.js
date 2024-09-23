var path = require('path');

module.exports = {
    entry: './src/main/js/app.js',
    devtool: 'source-map', // Ensure sourcemaps are generated correctly
    cache: true,
    mode: 'development',
    resolve: {
        alias: {
            // Keep this if you still want to use the alias for compatibility
            'stompjs': path.resolve(__dirname, 'node_modules/@stomp/stompjs/lib/stomp.js'),
        },
        fallback: {
            net: false, // fallback for the net module
        },
    },
    output: {
        path: path.resolve(__dirname, 'src/main/resources/static/built'), // Output directory
        filename: 'bundle.js', // Output filename
    },
    module: {
        rules: [
            {
                test: /\.js$/, // Ensure this applies to JavaScript files
                exclude: /(node_modules)/,
                use: [{
                    loader: 'babel-loader',
                    options: {
                        presets: ["@babel/preset-env", "@babel/preset-react"],
                    },
                }],
            },
        ],
    },
};