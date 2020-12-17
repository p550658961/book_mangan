package com.utils;

import java.util.UUID;

/**
 * 加密工具类
 */
public class MD5Utils {

    // 随机成功一个长度为8的uuid作为盐
    public static String md5(){
        UUID uuid = UUID.randomUUID();
        return uuid.toString().substring(0,8);
    }
}
