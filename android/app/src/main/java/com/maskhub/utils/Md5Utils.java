package com.maskhub.utils;


import java.io.File;
import java.io.FileInputStream;
import java.math.BigInteger;
import java.security.MessageDigest;

/**
 * MD5加密工具类
 *
 * @author xuexiang
 * @since 2018/7/2 下午3:14
 */
public final class Md5Utils {

    private Md5Utils() {
        throw new UnsupportedOperationException("cannot be instantiated");
    }
//
//    /**
//     * 获取文件的MD5值
//     *
//     * @param file
//     * @return
//     */
//    public static String getFileMD5(File file) {
//        if (!FileUtils.isFileExists(file)) {
//            return "";
//        }
//        InputStream fis = null;
//        try {
//            MessageDigest digest = MessageDigest.getInstance("MD5");
//            fis = FileUtils.getFileInputStream(file);
//            byte[] buffer = new byte[8192];
//            int len;
//            while ((len = fis.read(buffer)) != -1) {
//                digest.update(buffer, 0, len);
//            }
//            return bytes2Hex(digest.digest());
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            FileUtils.closeIOQuietly(fis);
//        }
//        return "";
//    }


    /**
     * 获取单个文件的MD5值！
     *
     * @param file
     * @return
     */

    public static String getFileMD5(File file) {
        if (!file.isFile()) {
            return null;
        }
        MessageDigest digest;
        FileInputStream in;
        byte[] buffer = new byte[1024];
        int len;
        try {
            digest = MessageDigest.getInstance("MD5");
            in = new FileInputStream(file);
            while ((len = in.read(buffer, 0, 1024)) != -1)
                digest.update(buffer, 0, len);
//            in.close();
            FileUtils.closeIOQuietly(in);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        BigInteger bigInt = new BigInteger(1, digest.digest());
        return bigInt.toString(16);
    }
}