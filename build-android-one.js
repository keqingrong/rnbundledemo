const chalk = require('chalk');
const {bundle, setPATH} = require('@keqingrong/react-native-cli-apis');
const info = (message = '') => console.info(chalk.cyanBright('info'), message);

/**
 * 打包成单个index.android.bundle文件
 */
async function main() {
  /** @type {import('@keqingrong/react-native-cli-apis').BundleConfig} */
  const config = {
    entryFile: 'index.js',
    platform: 'android',
    dev: false,
    bundleOutput: './android/app/src/main/assets/index.android.bundle',
    assetsDest: './android/app/src/main/res/',
  };
  const basePath = __dirname;
  const spawnOptions = {
    cwd: basePath,
    env: setPATH(basePath, process.env),
  };

  info('Building bundle for Android\n');
  await bundle(config, spawnOptions);
  info('Done building bundle for Android');
}

main();
