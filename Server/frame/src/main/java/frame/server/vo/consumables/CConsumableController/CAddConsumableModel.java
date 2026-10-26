package frame.server.vo.consumables.CConsumableController;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import com.alibaba.fastjson.JSONObject;

import frame.server.constant.ConsumableMaxCountConstant;
import frame.server.constant.Messages;
import frame.server.domain.Consumable;
import frame.server.utils.RandomUtil;
import frame.server.utils.StringUtil;
import frame.server.utils.ValidatorUtil;
import frame.server.vo.consumables.ReferenceInformationModel;
import lombok.Data;

/**
 * 新增消耗品Model
 * 
 * @author Administrator
 *
 */
@Data
public class CAddConsumableModel {

	// 仓库ID
	@NotBlank(message = Messages.badRequest)
	private String warehouseId;

	// 类型ID
	@NotBlank(message = Messages.badRequest)
	private String typeId;

	// 编码：根据code值生成条形码
	@NotBlank(message = "消耗品code不能为空")
	@Size(min = 1, max = 20, message = "消耗品code长度范围为1~20")
	private String code;

	// 名称
	@NotBlank(message = "消耗品名称不能为空")
	@Size(min = 1, max = 50, message = "消耗品名称长度范围为1~50")
	private String name;

	// 数量
	private int count;

	// 安全在工数
	private int safetyCount;

	// 价格
	private double price;

	// 简介
	@Size(min = 0, max = 255, message = "消耗品简介长度范围为0~255")
	private String summary;

	// 基准信息
	private JSONObject referenceInformations;

	public Consumable createConsumable() {
		return new Consumable(RandomUtil.genarateId(), warehouseId, null, typeId, code, name, count, safetyCount, price,
				summary, 1, new Date(), false, false);
	}

	public boolean validate() {
		return validateCode() && validateCount() && validateSafetyCount() && validatePrice() && validateReferenceInformations();
	}
	
	private boolean validateCode() {
		return ValidatorUtil.isConsumableCode(code);
	}

	// 校验数量
	private boolean validateCount() {
		return 0 <= count && count <= ConsumableMaxCountConstant.MAXINVENTORYCOUNT;
	}

	// 校验安全在工数
	private boolean validateSafetyCount() {
		return 0 <= safetyCount && safetyCount <= ConsumableMaxCountConstant.MAXINVENTORYCOUNT;
	}

	// 校验价格
	private boolean validatePrice() {
		return 0 <= price && price <= ConsumableMaxCountConstant.MAXPRICECOUNT;
	}
	
	// 校验基准信息
	private boolean validateReferenceInformations() {
		if(referenceInformations == null || referenceInformations.isEmpty()) {
			return true;
		}
		
		List<ReferenceInformationModel> referenceInformationList = JSONObject.parseArray(
				referenceInformations.getString("referenceInformations"), ReferenceInformationModel.class);
		
		for(ReferenceInformationModel referenceInformationModel : referenceInformationList) {
			String key = referenceInformationModel.getKey();
			String value = referenceInformationModel.getValue();
			
			if(!StringUtil.isBlank(key) && key.length() > 255) {
				return false;
			}
			
			if(!StringUtil.isBlank(value) && value.length() > 255) {
				return false;
			}
		}
		
		return true;
	}

}
