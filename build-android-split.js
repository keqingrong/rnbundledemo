const chalk = require('chalk');
const {bundle, version, setPATH} = require('@keqingrong/react-native-cli-apis');
const info = (message = '') => console.info(chalk.cyanBright('info'), message);

/**
 * 打包拆分为platform.android.bundle和index.android.bundle文件
 */
async function main() {
  /** @type {Array<import('@keqingrong/react-native-cli-apis').BundleConfig>} */
  const configs = [
    {
      entryFile: 'platformDep.js',
      platform: 'android',
      dev: false,
      bundleOutput: './android/app/src/main/assets/platform.android.bundle',
      assetsDest: './android/app/src/main/res/',
      config: './platform.config.js',
    },
    {
      entryFile: 'index.js',
      platform: 'android',
      dev: false,
      bundleOutput: './android/app/src/main/assets/index.android.bundle',
      assetsDest: './android/app/src/main/res/',
      config: './buz.config.js',
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
    switch (config.platform) {
      case 'android': {
        info('Building bundle for Android\n');
        await bundle(config, spawnOptions);
        info('Done building bundle for Android');
        break;
      }
      case 'ios': {
        info('Building bundle for iOS\n');
        await bundle(config, spawnOptions);
        info('Done building bundle for iOS');
        break;
      }
    }
  }

  info('All done');
}

main();
