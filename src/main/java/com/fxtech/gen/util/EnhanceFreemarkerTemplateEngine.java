/*
 * Fxtech.com
 * Copyright © 2022, Fxtech Co., Ltd. All Rights Reserved.
 */

package com.fxtech.gen.util;

import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

import java.io.File;
import java.util.Map;

/**
 * 代码生成器支持自定义[DTO\VO等]模版
 *
 * @author wangsheng
 * @since 12 七月 2022
 */
public final class EnhanceFreemarkerTemplateEngine extends FreemarkerTemplateEngine {

    @Override
    protected void outputCustomFile(Map<String, String> customFile, TableInfo tableInfo,
            Map<String, Object> objectMap) {
        String entityName = tableInfo.getEntityName();
        String otherPath = this.getPathInfo(OutputFile.other);
        String voPath = otherPath.replace("other", "vo");
        customFile.forEach((key, value) -> {
            if (key.equals("QueryReq") || key.equals("UpdateReq") || key.equals("SaveReq")) {
                String fileName = String
                        .format(voPath + File.separator + "req" + File.separator + entityName + "%s.java",
                                key);
                this.outputFile(new File(fileName), objectMap, value);
            } else if (key.equals("ListResp") || key.equals("DetailResp")) {
                String fileName = String
                        .format(voPath + File.separator + "resp" + File.separator + entityName + "%s.java",
                                key);
                this.outputFile(new File(fileName), objectMap, value);
            }
        });
    }
}
