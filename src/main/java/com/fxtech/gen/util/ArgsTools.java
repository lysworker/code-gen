package com.fxtech.gen.util;

import org.apache.commons.lang3.StringUtils;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class ArgsTools {
    private Map<String, String> data;

    private ArgsTools(Map<String, String> params) {
        this.data = new HashMap<>(params);
    }

    public static ArgsTools fromArgs(String[] args) {
        Map<String, String> map = new HashMap(args.length / 2);
        int i = 0;

        while (i < args.length) {
            String key;
            if (args[i].startsWith("--")) {
                key = args[i].substring(2);
            } else {
                if (!args[i].startsWith("-")) {
                    throw new IllegalArgumentException(String.format("解析参数失败: '%s'. 参数key必须以 - 为前缀.", args[i]));
                }

                key = args[i].substring(1);
            }

            if (key.isEmpty()) {
                throw new IllegalArgumentException("参数：" + Arrays.toString(args) + " 为空");
            }

            ++i;
            if (i >= args.length) {
                map.put(key, "__NO_VALUE_KEY");
            } else if (!args[i].startsWith("--") && !args[i].startsWith("-")) {
                map.put(key, args[i]);
                ++i;
            } else {
                map.put(key, "__NO_VALUE_KEY");
            }
        }
        return new ArgsTools(map);
    }

    public String get(String key) {
        if (StringUtils.isBlank(key)) {
            return null;
        }
        Object value = this.data.get(key);
        if(null == value){
            return "";
        }
        return value.toString();
    }

}
