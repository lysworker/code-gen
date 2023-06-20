package ${package.ServiceImpl};

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.cnnc.mes.constants.MesConstants;
import com.cnnc.mes.exception.MesExceptionType;
import java.util.Objects;
import com.cnnc.mes.web.BatchReq;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import com.cnnc.mes.exception.ServiceException;
import com.cnnc.mes.web.PageVO;
import com.cnnc.mes.web.BaseVO;
import ${package.Mapper}.${table.mapperName};
import ${package.Service}.${table.serviceName};
import ${package.Entity}.${entity};
import ${package.Parent}.vo.req.${entity}QueryReq;
import ${package.Parent}.vo.req.${entity}SaveReq;
import ${package.Parent}.vo.req.${entity}UpdateReq;
import ${package.Parent}.vo.resp.${entity}ListResp;
import ${package.Parent}.vo.resp.${entity}DetailResp;

/**
 * <p>
 * ${table.comment!} 服务实现类
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
@Slf4j
@Service
public class ${table.serviceImplName} extends ServiceImpl<${table.mapperName},${entity}> implements ${table.serviceName} {

    @Override
    public PageVO<${entity}ListResp> query${entity}ByPage(${entity}QueryReq query${entity}Req) {
        if(Objects.isNull(query${entity}Req)){
            query${entity}Req = new ${entity}QueryReq();
        }
        Page<${entity}> page = new Page<>(query${entity}Req.getCurrentPage(),query${entity}Req.getPageSize());
        return new PageVO(baseMapper.queryByList(page, query${entity}Req));
    }

    /**
    * 根据ID查询${table.comment!}明细详情
    * @param id 基础请求VO对象
    * @return string 返回主键ID
    */
    @Override
    public ${entity}DetailResp get${entity}ById(String id) {

        ${entity} ${entity ?uncap_first} = baseMapper.selectById(id);
        ${entity}DetailResp ${entity ?uncap_first}DetailResp = new ${entity}DetailResp();
        if(Objects.nonNull(${entity ?uncap_first})){
            BeanUtils.copyProperties(${entity ?uncap_first}, ${entity ?uncap_first}DetailResp);
        }
        return ${entity ?uncap_first}DetailResp;
    }

    /**
    * 新增${table.comment!}
    * @param ${entity ?uncap_first}SaveReq 基础请求VO对象
    */
    @Override
    public String save${entity}(${entity}SaveReq ${entity ?uncap_first}SaveReq) {
        if(Objects.isNull(${entity ?uncap_first}SaveReq)){
          return null;
        }
        String id = IdWorker.getIdStr();
        ${entity} ${entity ?uncap_first} = new ${entity}();
        ${entity ?uncap_first}.setId(id);
        BeanUtils.copyProperties(${entity ?uncap_first}SaveReq, ${entity ?uncap_first}, MesConstants.IGNORE_FIELD);
        baseMapper.insert(${entity ?uncap_first});
        return id;
    }

    /**
    * 根据主键ID编辑${table.comment!}
    * @param ${entity ?uncap_first}UpdateReq 基础请求VO对象
    * @return boolean 保存结果: true-成功,false-失败
    */
    @Override
    public Boolean update${entity}ById(${entity}UpdateReq ${entity ?uncap_first}UpdateReq) {
        if(StringUtils.isBlank(${entity ?uncap_first}UpdateReq.getId())){
            throw new ServiceException(MesExceptionType.ARGUMENT_NOT_VALID);
        }
        ${entity} ${entity ?uncap_first} = new ${entity}();
        BeanUtils.copyProperties(${entity ?uncap_first}UpdateReq, ${entity ?uncap_first});
        int result = baseMapper.updateById(${entity ?uncap_first});
        return result > 0;
    }

    /**
    * 根据主键ID删除${table.comment!}
    * @param baseVO 基础请求VO对象
    */
    @Override
    public void delete${entity}ById(BaseVO baseVO) {
        baseMapper.deleteById(baseVO.getId());
    }

    /**
    * 批量删除${table.comment!}
    * @param batchReq 基础请求集合对象
    */
    @Override
    public boolean deleteBatch(BatchReq batchReq) {
    if(batchReq.getIds().isEmpty()){
    throw new ServiceException(MesExceptionType.ARGUMENT_NOT_VALID);
    }
    return  baseMapper.deleteBatchIds(batchReq.getIds())>0;
    }

}