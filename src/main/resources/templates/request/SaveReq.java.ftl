package ${package.Parent}.vo.req;

import com.cnnc.mes.web.BaseVO;
import javax.validation.constraints.*;
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
* ${table.comment!}新增请求对象
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
@ApiModel(value="${entity}SaveReqReq新增请求VO", description="${table.comment!}新增请求VO")
public class ${entity}SaveReq extends BaseVO {

<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list table.fields as field>
    <#if "${field.propertyName}" != "createTime"
    && "${field.propertyName}" != "id"
    && "${field.propertyName}" != "updateTime"
    && "${field.propertyName}" != "createBy"
    && "${field.propertyName}" != "updateBy"
    && "${field.propertyName}" != "version"
    && "${field.propertyName}" != "is_delete"
    && "${field.propertyName}" != "status">
    @ApiModelProperty(value = "${field.comment}",required = true)
    <#if "${field.keyFlag?string('1','0')}" == '1'>
    @NotEmpty(message = "${field.comment}不能为空")
    </#if>
    private ${field.propertyType} ${field.propertyName};
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
