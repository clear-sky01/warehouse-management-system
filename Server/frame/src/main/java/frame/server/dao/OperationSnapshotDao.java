package frame.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Lang;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import frame.server.config.mybatis.SimpleInsertExtendedLanguageDriver;
import frame.server.domain.OperationSnapshot;

@Mapper
public interface OperationSnapshotDao {

    @Insert("insert into operation_snapshot (#{snapshot})")
    @Lang(SimpleInsertExtendedLanguageDriver.class)
    int insert(OperationSnapshot snapshot);

    @Insert("<script>insert into operation_snapshot "
            + "(id, operation_id, entity_type, entity_id, field_name, old_value, new_value) values "
            + "<foreach collection='list' item='item' separator=','>"
            + "(#{item.id}, #{item.operationId}, #{item.entityType}, #{item.entityId}, "
            + "#{item.fieldName}, #{item.oldValue}, #{item.newValue})"
            + "</foreach></script>")
    int batchInsert(List<OperationSnapshot> snapshots);

    @Select("select * from operation_snapshot where operation_id = #{operationId} order by field_name")
    List<OperationSnapshot> selectByOperationId(String operationId);

    @Select("select * from operation_snapshot where entity_type = #{entityType} and entity_id = #{entityId}")
    List<OperationSnapshot> selectByEntity(@Param("entityType") String entityType,
                                           @Param("entityId") String entityId);

    @Delete("<script>delete from operation_snapshot where operation_id in "
            + "<foreach collection='list' item='id' open='(' separator=',' close=')'>#{id}</foreach></script>")
    int deleteByOperationIds(List<String> operationIds);
}