const chalk = require('chalk');
const {bundle, version, setPATH} = require('@keqingrong/react-native-cli-apis');
const info = (message = '') => console.info(chalk.cyanBright('info'), message);

/**
 * 打包index1.js和index2.js
 */
async function main() {
  /** @type {Array<import('@keqingrong/react-native-cli-apis').BundleConfig>} */
  const configs = [
    {
      entryFile: 'index1.js',
      platform: 'android',
      dev: false,
      bundleOutput: './android/app/src/main/assets/index1.android.bundle',
      assetsDest: './android/app/src/main/res/',
    },
    {
      entryFile: 'index2.js',
      platform: 'android',
      dev: false,
      bundleOutput: './android/app/src/main/assets/index2.android.bundle',
      assetsDest: './android/app/src/main/res/',
    },
  ];

  const basePath = __dirname;
  const spawnOptions = {
    cwd: basePath,
    env: setPATH(basePath, process.env),
  };

  info('React Native CLI version');
  await version();

  for await (let config of configs) {
    info('Building bundle for Android\n');
    await bundle(config, spawnOptions);
    info('Done building bundle for Android');
    break;
  }

  info('All done');
}

main();
