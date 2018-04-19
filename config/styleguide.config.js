module.exports = {
    components: '../react/src/components/**/*.{ts,tsx}',
    ignore: ['**/components/Debug/Debug.tsx'],
    webpackConfig: require('./webpack/webpack.config.dev.js'),
    propsParser: require('react-docgen-typescript').withDefaultConfig({ propFilter: { skipPropsWithoutDoc: true } }).parse
}