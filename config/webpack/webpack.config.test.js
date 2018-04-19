'use strict';

process.env.BABEL_ENV = 'test';
process.env.NODE_ENV = 'test';
process.env.PUBLIC_URL = '';

const webpack = require('webpack');
const nodeExternals = require('webpack-node-externals');
const paths = require('./paths');

module.exports = {
    devtool: 'inline-source-map',
    target: 'node',
    externals: [nodeExternals()],
    resolve: {
        extensions: ['.ts', '.tsx', '.js', '.json']
    },
    module: {
        strictExportPresence: true,
        rules: [
            {
                test: /\.(js|ts)/,
                include: paths.appSrc, // instrument only testing sources with Istanbul, after ts-loader runs
                loader: require.resolve('istanbul-instrumenter-loader')
            }, {
                test: /\.js$/,
                loader: require.resolve('source-map-loader'),
                enforce: 'pre',
            }, {
                oneOf: [
                    {
                        test: [/\.bmp$/, /\.gif$/, /\.jpe?g$/, /\.png$/],
                        loader: require.resolve('url-loader'),
                        options: {
                            limit: 10000,
                            name: 'static/media/[name].[hash:8].[ext]',
                        },
                    }, {
                        test: /\.(ts|tsx)$/,
                        loader: require.resolve('ts-loader'),
                        options: {
                            transpileOnly: true,
                            configFile: 'tsconfig.test.json'
                        }
                    }, {
                        test: /\.css$/,
                        use: [
                            'css-loader/locals?modules'
                        ]
                    }, {
                        exclude: [/\.js$/, /\.json$/],
                        loader: require.resolve('file-loader'),
                        options: {
                            name: 'static/media/[name].[hash:8].[ext]',
                        },
                    },
                ],
            },
        ],
    },
    watchOptions: {
        poll: 1000
    },
    plugins: [
        new webpack.IgnorePlugin(/^\.\/locale$/, /moment$/),
    ],
};
