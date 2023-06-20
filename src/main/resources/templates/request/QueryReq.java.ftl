package ${package.Parent}.vo.req;

import com.cnnc.mes.web.BaseQueryReq;
<#list table.importPackages as pkg>
import ${pkg};
</#list>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
<#if entityLombokModel>
import lombok.Getter;
import lombok.Setter;
<#if chainModel>
import lombok.experimental.Accessors;
</#if>
</#if>

/**
* ${table.comment!}分页查询请求VO
* @author ${author}
* @since ${date}
*/
<#if entityLombokModel>
@Getter
@Setter
    <#if chainModel>
@Accessors(chain = true)
    </#if>
</#if>
@ApiModel(value="${entity}QueryReq分页查询请求VO", description="${table.comment!}分页查询请求VO")
public class ${entity}QueryReq extends BaseQueryReq {

<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list table.fields as field>
    <#if "${field.propertyName}" != "version"
    && "${field.propertyName}" != "is_delete">
    <#if "${field.propertyName}" == "createTime" || "${field.propertyName}" == "updateTime" >
    @ApiModelProperty(value = "${field.comment}开始")
    private ${field.propertyType} ${field.propertyName}Begin;
    @ApiModelProperty(value = "${field.comment}结束")
    private ${field.propertyType} ${field.propertyName}End;
    <#else>
    @ApiModelProperty(value = "${field.comment}")
    private ${field.propertyType} ${field.propertyName};
    </#if>
    </#if>
</#list>
<#------------  END 字段循环遍历  ---------->

<#if !entityLombokModel>
    <#list table.fields as field>
        <#if field.propertyType == "boolean">
            <#assign getprefix="is"/>
        <#else>
            <#assign getprefix="get"/>
        </#if>
        public ${field.propertyType} ${getprefix}${field.capitalName}() {
        return ${field.propertyName};
        }

        <#if chainModel>
            public ${entity} set${field.capitalName}(${field.propertyType} ${field.propertyName}) {
        <#else>
            public void set${field.capitalName}(${field.propertyType} ${field.propertyName}) {
        </#if>
        this.${field.propertyName} = ${field.propertyName};
        <#if chainModel>
            return this;
        </#if>
        }
    </#list>
</#if>
}
