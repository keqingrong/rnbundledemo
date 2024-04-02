package com.rnbundledemo;

import static com.maskhub.Constants.FAILURE;
import static com.maskhub.Constants.SUCCESS;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.Nullable;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.maskhub.BundleEntity;
import com.maskhub.VersionCheckerDelegate;

import org.jetbrains.annotations.NotNull;

import java.io.IOException;
import java.util.Map;
import java.util.Objects;

import okhttp3.Call;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

/**
 * 自定义获取 BUNDLE 代理
 */
public class MiniAppVersionCheckDelegate implements VersionCheckerDelegate {

    private final Context mContext;

    private String mURL;
    private final OkHttpClient client = new OkHttpClient();
    private final Gson gson = new Gson();

    public MiniAppVersionCheckDelegate(Context context,String url) {
        this.mContext = context;
        this.mURL = url;
    }

    @Override
    public void processCheckResult(Map<String, Object> params, Callback callback) {
        Request request = new Request.Builder()
//                .url("https://tuicr.oss-cn-hangzhou.aliyuncs.com/jsbundle/demo/data_0.73.6.json")
                .url(this.mURL)
                .build();

        client.newCall(request).enqueue(new okhttp3.Callback() {
            @Override
            public void onFailure(@NotNull Call call, @NotNull IOException e) {
                callback.onResult(FAILURE, null);
            }

            @Override
            public void onResponse(@NotNull Call call, @NotNull Response response) throws IOException {
                String body = Objects.requireNonNull(response.body()).string();
                BaseResponse<Map<String, String>> res = gson.fromJson(body, new TypeToken<BaseResponse<Map<String, String>>>() {
                }.getType());

                Map<String, String> result = res.getData();
                BundleEntity entity = new BundleEntity();
                entity.setVersion(result.get("version"));
                entity.setUrl(result.get("ossUrl"));
                entity.setVerifyCode(result.get("md5code"));
                callback.onResult(SUCCESS, entity);
            }
        });
    }

    @Override
    public BundleEntity lastVersion(String name) {
        SharedPreferences sp = getSharedPreferences();
        if (null != sp) {
            String content = sp.getString(name, "{}");
            return gson.fromJson(content, new TypeToken<BundleEntity>() {
            }.getType());
        }
        return null;
    }

    @Override
    public void putVersion(String name, BundleEntity version) {
        String content = gson.toJson(version);
        SharedPreferences sp = getSharedPreferences();
        if (null != sp) {
            sp.edit().putString(name, content).apply();
        }
    }

    private SharedPreferences getSharedPreferences() {
        return mContext.getSharedPreferences(SP_VERSION_KEY, Context.MODE_PRIVATE);
    }

    @Override
    public boolean hasVersion(@Nullable BundleEntity oldVersion, @Nullable BundleEntity newVersion) {
        String oVer = oldVersion != null ? oldVersion.getVersion() : "";
        String nVer = newVersion != null ? newVersion.getVersion() : "";
        return !Objects.equals(nVer, oVer);
    }


    private static final String SP_VERSION_KEY = "mask_hub";

    static class BaseResponse<T> {
        private T data;
        private long code;
        private String message;

        public T getData() {
            return data;
        }

        public void setData(T data) {
            this.data = data;
        }

        public long getCode() {
            return code;
        }

        public void setCode(long code) {
            this.code = code;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }
}
