package com.fxtech.gen.util;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.IFill;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.InjectionConfig.Builder;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.fill.Column;

import java.io.File;
import java.util.*;

/**
 * 代码生成器 工具类
 * 
 * @author wangsheng
 */
public class GenUtils {

    /**
     * 数据源配置
     */
    protected static DataSourceConfig DataSourceConfig(){
        return new DataSourceConfig
                .Builder("jdbc:mysql://49.233.210.232:3306/mes?serverTimezone=Asia/Shanghai", "root", "P_assw0rD")
//                .schema("cx_third")
                .build();
    }

    protected static String getJavaBasePath(){
        return "D:\\work\\file\\ruiyi\\code\\develop"+"/cnnc-mes/src/main/java";
    }

    protected static String getResourcePath(String moduleName) {
        return "D:\\work\\file\\ruiyi\\code\\develop" + "/cnnc-mes/src/main/resources/mapper"+ File.separator + moduleName;
    }

    /**
     * 策略配置
     */
    protected static StrategyConfig.Builder strategyConfig(List<String> tableNames) {
        StrategyConfig.Builder strategyBuilder = new StrategyConfig.Builder()
                .addInclude(
                        tableNames
                ) // 设置需要生成的表名
                .addTablePrefix("sys_", "tt_", "tm_", "tr_")// 设置过滤表前缀
                ;
        List<IFill> fillList = new ArrayList<>();
        fillList.add(new Column("create_by", FieldFill.INSERT));
        fillList.add(new Column("update_by", FieldFill.INSERT_UPDATE));
        strategyBuilder.entityBuilder()//Entity 策略配置
                .enableLombok()//开启 lombok 模型
                .enableRemoveIsPrefix()//Boolean 类型字段移除 is 前缀
                .enableTableFieldAnnotation()//开启生成实体时生成字段注解
                .versionColumnName("version")//乐观锁字段名(数据库)
                .versionPropertyName("version")//乐观锁属性名(实体)
                .logicDeleteColumnName("is_delete")//逻辑删除字段名(数据库)
                .logicDeletePropertyName("isDelete")//逻辑删除属性名(实体)
                .naming(NamingStrategy.underline_to_camel)//数据库表映射到实体的命名策略:下划线转驼峰命
                .addTableFills(fillList)
                .idType(IdType.ASSIGN_ID)
                ;
        strategyBuilder.controllerBuilder()//Controller 策略配置
                .enableHyphenStyle()//开启驼峰转连字符
                .enableRestStyle()//生成@RestController 控制器
                ;
        strategyBuilder.mapperBuilder()
                .enableBaseResultMap()//启用 BaseResultMap 生成
                .enableBaseColumnList()//启用 BaseColumnList
                ;

        return strategyBuilder;
    }

    /**
     * 全局配置
     */
    protected static GlobalConfig.Builder globalConfig() {
        return new GlobalConfig.Builder()
                .author("Bill Liu") // 设置作者
                .enableSwagger() // 开启 swagger 模式
                .fileOverride() // 覆盖已生成文件
                .outputDir(getJavaBasePath()); // 指定输出目录
    }

    /**
     * 包配置
     */
    protected static PackageConfig.Builder packageConfig(String moduleName) {
        Map<OutputFile, String> otherMap = new HashMap<>();
        otherMap.put(OutputFile.mapperXml, getResourcePath(moduleName));
        return new PackageConfig.Builder()
                .parent("com.cnnc.mes") // 设置父包名
                .moduleName(moduleName) // 设置父包模块名
                .controller("rest.v1")//controller路径
                .mapper("dao").pathInfo(otherMap); // 设置mapperXml生成路径
    }

    /**
     * 模板配置
     */
    protected static TemplateConfig.Builder templateConfig() {
        return new TemplateConfig.Builder()
                .service("/templates/service.java")
                .serviceImpl("/templates/serviceImpl.java")
                .controller("/templates/controller.java")
                .mapper("/templates/mapper.java");
    }

    /**
     * 注入配置
     */
    protected static InjectionConfig.Builder injectionConfig(String moduleName) {
        // 设置自定义属性
        Map<String, Object> map = new HashMap<>();
        map.put("ModuleName", moduleName);

        // 设置自定义输出文件
        Map<String, String> customFile = new HashMap<>();
        customFile.put("QueryReq", "/templates/request/QueryReq.java.ftl");
        customFile.put("UpdateReq", "/templates/request/UpdateReq.java.ftl");
        customFile.put("SaveReq", "/templates/request/SaveReq.java.ftl");
        customFile.put("ListResp", "/templates/response/ListResp.java.ftl");
        customFile.put("DetailResp", "/templates/response/DetailResp.java.ftl");
        // 测试自定义输出文件之前注入操作，该操作再执行生成代码前 debug 查看
        Builder config = new Builder()
                .customFile(customFile)
                .beforeOutputFile((tableInfo, objectMap) -> {
                    System.out.println("tableInfo: " + tableInfo.getEntityName() + " objectMap: " + objectMap.size());
                }).customMap(map);
        return config;
    }

    public static void main(String[] arg) throws Exception {
        String moduleName = "productmanage";
        List<String> tableNames = Arrays.asList("tr_product_material");
        AutoGenerator generator = new AutoGenerator(DataSourceConfig());
        generator.strategy(strategyConfig(tableNames).build());
        generator.packageInfo(packageConfig(moduleName).build());
        generator.injection(injectionConfig(moduleName).build());
        generator.template(templateConfig().build());
        generator.global(globalConfig().build());
        generator.execute(new EnhanceFreemarkerTemplateEngine());
    }
}
