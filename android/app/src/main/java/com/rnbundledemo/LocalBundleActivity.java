package com.rnbundledemo;

import com.facebook.react.AsyncReactActivity;


public class LocalBundleActivity extends AsyncReactActivity {
    /**
     * Returns the name of the main component registered from JavaScript.
     * This is used to schedule rendering of the component.
     */
    @Override
    protected String getMainComponentName() {
        return "RNBundleDemo1";
    }

    @Override
    protected RnBundle getBundle() {
        RnBundle bundle = new RnBundle();
        bundle.scriptType = ScriptType.ASSET;
        bundle.scriptPath = "index1.android.bundle";
        bundle.scriptUrl = "index1.android.bundle";
        return bundle;
    }

}
