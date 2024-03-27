package com.rnbundledemo;

import com.facebook.react.AsyncReactActivity;

public class RemoteBundleActivity extends AsyncReactActivity {
    /**
     * Returns the name of the main component registered from JavaScript.
     * This is used to schedule rendering of the component.
     */
    @Override
    protected String getMainComponentName() {
        return "RNBundleDemo2";
    }

    @Override
    protected RnBundle getBundle() {
        RnBundle bundle = new RnBundle();
        bundle.scriptType = ScriptType.NETWORK;
        bundle.scriptPath = "index2.android.bundle";
        bundle.scriptUrl = "https://github.com/smallnew/react-native-multibundler/raw/master/remotebundles/index2.android.bundle.zip";
        return bundle;
    }

}
