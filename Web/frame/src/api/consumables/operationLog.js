import { get, post } from "../../utils/http";

// 获取系统操作日志(分页)
export const getOperationLogsApi = p => post("/cOperationLog/getLogs", p);

// 获取某条操作的字段变更详情
export const getOperationSnapshotApi = p => get("/cOperationLog/getSnapshot", p);