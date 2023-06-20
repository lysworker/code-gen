package ${package.Service};

import com.baomidou.mybatisplus.extension.service.IService;
import com.cnnc.mes.web.BatchReq;
import com.cnnc.mes.web.PageVO;
import com.cnnc.mes.web.BaseVO;
import ${package.Entity}.${entity};
import ${package.Parent}.vo.req.${entity}QueryReq;
import ${package.Parent}.vo.req.${entity}SaveReq;
import ${package.Parent}.vo.req.${entity}UpdateReq;
import ${package.Parent}.vo.resp.${entity}ListResp;
import ${package.Parent}.vo.resp.${entity}DetailResp;


/**
 * <p>
 * ${table.comment!} 服务类
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */

public interface ${table.serviceName} extends IService<${entity}> {

    /**
    * 分页查询列表
    * @param query${entity}Req 查询参数对象
    * @return PageVO<${entity}ListResp> 分页列表
    */
    PageVO<${entity}ListResp> query${entity}ByPage(${entity}QueryReq query${entity}Req);

    /**
    * 根据ID查询${table.comment!}明细详情
    * @param id 基础请求VO对象
    * @return string 返回主键ID
    */
    ${entity}DetailResp get${entity}ById(String id);

    /**
    * 新增${table.comment!}
    * @param ${entity ?uncap_first}SaveReq 基础请求VO对象
    */
    String save${entity}(${entity}SaveReq ${entity ?uncap_first}SaveReq);

    /**
    * 根据主键ID编辑${table.comment!}
    * @param ${entity ?uncap_first}UpdateReq 基础请求VO对象
    * @return boolean 保存结果: true-成功,false-失败
    */
    Boolean update${entity}ById(${entity}UpdateReq ${entity ?uncap_first}UpdateReq);

    /**
    * 根据主键ID删除${table.comment!}
    * @param baseVO 基础请求VO对象
    */
    void delete${entity}ById(BaseVO baseVO);

    /**
    *批量删除${table.comment!}
    * @param batchReq
    * @return
    */
    boolean deleteBatch(BatchReq batchReq);
}