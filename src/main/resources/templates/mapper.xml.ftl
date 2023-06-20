<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package.Mapper}.${table.mapperName}">

<#if enableCache>
    <!-- 开启二级缓存 -->
    <cache type="org.mybatis.caches.ehcache.LoggingEhcache"/>

</#if>
<#if baseResultMap>
    <!-- 通用查询映射结果 -->
    <resultMap id="BaseResultMap" type="${package.Entity}.${entity}">
<#list table.fields as field>
<#if field.keyFlag><#--生成主键排在第一位-->
        <id column="${field.name}" property="${field.propertyName}" />
</#if>
</#list>
<#list table.commonFields as field><#--生成公共字段 -->
        <result column="${field.name}" property="${field.propertyName}" />
</#list>
<#list table.fields as field>
<#if !field.keyFlag><#--生成普通字段 -->
        <result column="${field.name}" property="${field.propertyName}" />
</#if>
</#list>
    </resultMap>

</#if>
<#if baseColumnList>
    <!-- 通用查询结果列 -->
    <sql id="Base_Column_List">
<#list table.commonFields as field>
        ${field.name},
</#list>
        ${table.fieldNames}
    </sql>

</#if>

  <select id="queryByList" resultType="${package.Parent}.vo.resp.${entity}ListResp">
      SELECT <include refid="Base_Column_List" />
      FROM ${table.name} t
      <where>
   <#list table.fields as field>
     <#if "${field.propertyName}" != "version" >
     <#if "${field.propertyName}" == "createTime">
       <if test="fx.${field.propertyName}Begin != null">
         AND t.${field.name} <![CDATA[ >= ]]> ${r'#{' } fx.${field.propertyName}Begin ${r'}' }
       </if>
       <if test="fx.${field.propertyName}End != null">
         AND t.${field.name} <![CDATA[ <= ]]> ${r'#{' } fx.${field.propertyName}End ${r'}' }
       </if>
     </#if>
     <#if "${field.propertyName}" == "updateTime">
       <if test="fx.${field.propertyName}Begin != null">
         AND t.${field.name} <![CDATA[ >= ]]> ${r'#{' } fx.${field.propertyName}Begin ${r'}' }
       </if>
       <if test="fx.${field.propertyName}End != null">
         AND t.${field.name} <![CDATA[ <= ]]> ${r'#{' } fx.${field.propertyName}End ${r'}' }
       </if>
     </#if>
     <#if "${field.propertyName}" != "createTime" && "${field.propertyName}" != "updateTime" >
       <#if "${field.propertyType}" != "String">
       <if test="fx.${field.propertyName} != null">
         AND t.${field.name} = ${r'#{' } fx.${field.propertyName} ${r'}' }
       </if>
       <#else>
       <if test="fx.${field.propertyName} != null  and fx.${field.propertyName} != ''">
         AND t.${field.name} = ${r'#{' } fx.${field.propertyName} ${r'}' }
       </if>
       </#if>
     </#if>
     </#if>
    </#list>
        </where>
        order by t.update_time desc
   </select>
</mapper>
