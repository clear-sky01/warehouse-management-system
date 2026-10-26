package frame.server.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Lang;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import frame.server.config.mybatis.SimpleInsertExtendedLanguageDriver;
import frame.server.domain.Operation;
import frame.server.dto.OperationDto;

@Mapper
public interface OperationDao {

	@Insert("insert into operation (#{operation})")
	@Lang(SimpleInsertExtendedLanguageDriver.class)
	Integer insert(Operation operation);

	@Delete("delete from operation")
	Integer clear();

	@Select("select t1.*, t2.name as user_name from operation as t1 "
			+ "left join user as t2 on t1.user_id = t2.id order by create_time desc")
	List<OperationDto> selectAll();

	@Select("select t1.*, t2.name as user_name from operation as t1 "
			+ "left join user as t2 on t1.user_id = t2.id "
			+ "where t1.user_id = #{userId} order by create_time desc")
	List<OperationDto> selectByUserId(String userId);

	@Select("select t1.*, t2.name as user_name from operation as t1 "
			+ "left join user as t2 on t1.user_id = t2.id "
			+ "where t1.operation like concat('%', #{keyword}, '%') order by create_time desc")
	List<OperationDto> selectByOperation(String keyword);

	@Select("select t1.*, t2.name as user_name from operation as t1 "
			+ "left join user as t2 on t1.user_id = t2.id "
			+ "where t1.create_time >= #{startTime} and t1.create_time <= #{endTime} order by create_time desc")
	List<OperationDto> selectByTimeRange(@Param("startTime") String startTime, @Param("endTime") String endTime);

	@Select("select t1.*, t2.name as user_name from operation as t1 "
			+ "left join user as t2 on t1.user_id = t2.id "
			+ "where t1.user_id = #{userId} and t1.operation like concat('%', #{keyword}, '%') order by create_time desc")
	List<OperationDto> selectByUserIdAndOperation(@Param("userId") String userId, @Param("keyword") String keyword);

	@Select("select id from operation where create_time < #{beforeDate}")
	List<String> selectIdsBeforeDate(Date beforeDate);

	@Delete("<script>delete from operation where id in "
			+ "<foreach collection='list' item='id' open='(' separator=',' close=')'>#{id}</foreach></script>")
	int deleteByIds(List<String> ids);
}