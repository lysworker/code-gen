package ${package.Mapper};

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import ${package.Entity}.${entity};
import ${package.Parent}.vo.req.${entity}QueryReq;
import ${package.Parent}.vo.resp.${entity}ListResp;

/**
 * <p>
 * ${table.comment!} Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
public interface ${table.mapperName} extends BaseMapper<${entity}> {

    IPage<${entity}ListResp> queryByList(Page<${entity}> page, @Param("fx")${entity}QueryReq query${entity}Req);
}