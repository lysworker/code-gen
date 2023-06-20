package ${package.Controller};

import com.cnnc.mes.web.ApiResult;
import com.cnnc.mes.web.PageVO;
import com.cnnc.mes.web.BaseVO;
import com.cnnc.mes.web.BatchReq;
import ${package.Mapper}.${table.mapperName};
import ${package.Service}.${table.serviceName};
import ${package.Entity}.${entity};
import ${package.Parent}.vo.req.${entity}QueryReq;
import ${package.Parent}.vo.req.${entity}SaveReq;
import ${package.Parent}.vo.req.${entity}UpdateReq;
import ${package.Parent}.vo.resp.${entity}ListResp;
import ${package.Parent}.vo.resp.${entity}DetailResp;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;


/**
* <p>
    * ${table.comment!} 控制器
    * </p>
*
* @author ${author}
* @since ${date}
*/
@Api(tags = "${table.comment!}")
@RestController
@RequestMapping("/${ModuleName}/${entity ?uncap_first}")
public class ${table.controllerName}  {

    @Autowired
    private ${table.serviceName} ${entity ?uncap_first}Service;

    @PostMapping("/page")
    @ApiOperation(value = "${table.comment!}-分页查询")
    public ApiResult<PageVO<${entity}ListResp>> query${entity}ByPage(@Valid @RequestBody(required = false) ${entity}QueryReq ${entity ?uncap_first}QueryReq) {
        return ApiResult.success(${entity ?uncap_first}Service.query${entity}ByPage(${entity ?uncap_first}QueryReq));
    }

    @GetMapping("/get/{id}")
    @ApiOperation(value = "${table.comment!}-查询明细")
    public ApiResult<${entity}DetailResp> get${entity}ById(@PathVariable String id) {
        return ApiResult.success(${entity ?uncap_first}Service.get${entity}ById(id));
    }

    @PostMapping("/save")
    @ApiOperation(value = "${table.comment!}-新增")
    public ApiResult<String> save${entity}(@Valid @RequestBody(required = false) ${entity}SaveReq ${entity ?uncap_first}SaveReq) {
        return ApiResult.success(${entity ?uncap_first}Service.save${entity}(${entity ?uncap_first}SaveReq));
    }

    @PostMapping("/update")
    @ApiOperation(value = "${table.comment!}-编辑")
    public ApiResult<Boolean> update${entity}ById(@Valid @RequestBody(required = false) ${entity}UpdateReq ${entity ?uncap_first}UpdateReq) {
        return ApiResult.success(${entity ?uncap_first}Service.update${entity}ById(${entity ?uncap_first}UpdateReq));
    }

    @PostMapping("/delete")
    @ApiOperation(value = "${table.comment!}-删除")
    public ApiResult<Void> delete${entity}ById(@RequestBody BaseVO baseVO) {
        ${entity ?uncap_first}Service.delete${entity}ById(baseVO);
        return ApiResult.success();
    }

    @PostMapping("/deleteBatch")
    @ApiOperation(value = "${table.comment!}-批量删除")
    public ApiResult<Void> deleteBatch(@RequestBody BatchReq batchReq) {
        return ${entity ?uncap_first}Service.deleteBatch(batchReq) ? ApiResult.success() : ApiResult.fail();
    }
}