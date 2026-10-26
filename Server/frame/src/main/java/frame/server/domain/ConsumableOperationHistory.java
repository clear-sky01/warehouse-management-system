package frame.server.domain;

import java.util.Date;

import frame.server.utils.DateUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ConsumableOperationHistory {

	private String id;
	private String warehouseId;
	private String userId;
	private Date createTime;
	private String ip;   // ← 新加

	public String getCreateTime() {
		if(createTime != null) {
			return DateUtil.convertDateToString(createTime, DateUtil.DATE_TIME_FORMAT_YYYY_MM_DD_HH_MI);
		}
		return "";
	}
}