package com.rnbundledemo

import android.app.Application
import android.content.Context
import com.facebook.react.PackageList
import com.facebook.react.ReactApplication
import com.facebook.react.ReactInstanceManager
import com.facebook.react.ReactNativeHost
import com.facebook.react.ReactPackage
import com.facebook.soloader.SoLoader
import com.maskhub.Constants
import com.maskhub.Options
import com.maskhub.utils.MaskLog.AndroidLog
import java.io.File
import java.lang.reflect.InvocationTargetException


class MainApplication : Application(), ReactApplication {
    override fun onCreate() {
        super.onCreate()
        Options.me()
                .contextDir(File(this.filesDir, Constants.BUNDLE_FOLDER_PREFIX).absolutePath) //bundle模块储存路径
                .debug(BuildConfig.DEBUG) //是否启用debug模式
                .log(AndroidLog()) //是否需要定制日志
                .delegate(MiniAppVersionCheckDelegate(this,"https://tuicr.oss-cn-hangzhou.aliyuncs.com/jsbundle/demo/data_index1.json")) //对接苏宁等第三方发布平台
                .reactInstanceManager(mReactNativeHost.reactInstanceManager) //react native 管理托管类


//        Page page = new Page()
//                .name("app")
//                .url("rn://app/index.android.jsbundle");
//
//        LoadReactActivity.build(this).page(page).start();
        SoLoader.init(this,  /* native exopackage */false)
        initializeFlipper(this, reactNativeHost.reactInstanceManager)
    }

    override fun getReactNativeHost(): ReactNativeHost {
        return mReactNativeHost
    }

    private val mReactNativeHost: ReactNativeHost = object : ReactNativeHost(this) {
        override fun getUseDeveloperSupport(): Boolean {
            return BuildConfig.DEBUG
        }

        override fun getPackages(): List<ReactPackage> {
            // Packages that cannot be autolinked yet can be added manually here, for example:
            // packages.add(new MyReactNativePackage());
            return PackageList(this).getPackages()
        }

        override fun getJSMainModuleName(): String {
            return "index"
        }
    }

    companion object {
        /**
         * Loads Flipper in React Native templates. Call this in the onCreate method with something like
         * initializeFlipper(this, getReactNativeHost().getReactInstanceManager());
         *
         * @param context
         * @param reactInstanceManager
         */
        private fun initializeFlipper(
                context: Context, reactInstanceManager: ReactInstanceManager) {
            if (BuildConfig.DEBUG) {
                try {
                    /*
         We use reflection here to pick up the class that initializes Flipper,
        since Flipper library is not available in release mode
        */
                    val aClass = Class.forName("com.app.ReactNativeFlipper")
                    aClass
                            .getMethod("initializeFlipper", Context::class.java, ReactInstanceManager::class.java)
                            .invoke(null, context, reactInstanceManager)
                } catch (e: ClassNotFoundException) {
                    e.printStackTrace()
                } catch (e: NoSuchMethodException) {
                    e.printStackTrace()
                } catch (e: IllegalAccessException) {
                    e.printStackTrace()
                } catch (e: InvocationTargetException) {
                    e.printStackTrace()
                }
            }
        }
    }
}

