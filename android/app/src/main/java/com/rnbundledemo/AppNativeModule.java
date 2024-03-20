package com.rnbundledemo;
import android.app.Activity;
import android.content.Intent;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.JSApplicationIllegalArgumentException;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;


public class AppNativeModule extends ReactContextBaseJavaModule{

    public AppNativeModule(@Nullable ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @NonNull
    @Override
    public String getName() {
        // 返回原生模块注册时的名称，也就是说从 react 层的 js 代码中调用 AppModule 这个原生模块，必须先知道这个模块叫什么名称
        // 这里约定 AppModule 原生模块暴露的名字叫 CustomApp，也可以叫其它的
        return "AppNativeModule";
    }

    @ReactMethod
    public void startActivityFromJS(String name, String params){
        try{
            Activity currentActivity = getCurrentActivity();
            if(null!=currentActivity){
                Class toActivity = Class.forName(name);
                Intent intent = new Intent(currentActivity,toActivity);
                intent.putExtra("params", params);
                currentActivity.startActivity(intent);
            }
        }catch(Exception e){
            throw new JSApplicationIllegalArgumentException(
                    "不能打开Activity : "+e.getMessage());
        }
    }

    @ReactMethod
    public void openLocalBundlePage() {
        Activity currentActivity = getCurrentActivity();
        if(null!=currentActivity){
            Intent intent = new Intent(currentActivity,LocalBundleActivity.class);
            //intent.putExtra("params", params);
            currentActivity.startActivity(intent);
        }
    }


    @ReactMethod
    public void openRemoteBundlePage() {
        Activity currentActivity = getCurrentActivity();
        if(null!=currentActivity){
            Intent intent = new Intent(currentActivity,RemoteBundleActivity.class);
            //intent.putExtra("params", params);
            currentActivity.startActivity(intent);
        }
    }
}