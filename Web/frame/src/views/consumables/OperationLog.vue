<template>
  <div class="operation-log-container">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item v-for="(item, index) in breadcrumbs" :key="index">{{ item }}</el-breadcrumb-item>
    </el-breadcrumb>
    <hr />
    <el-row class="operation-container">
      <el-col :span="20" class="search-container">
        <el-select v-model="searchType" placeholder="请选择检索类型" clearable style="width:130px;">
          <el-option label="操作描述" value="3" />
          <el-option label="用户ID" value="1" />
        </el-select>
        <el-input v-model="searchStr" placeholder="请输入检索内容" clearable style="width:350px; margin-left:10px;" />
        <el-button type="primary" icon="el-icon-search" @click="doSearch" style="margin-left:10px;">搜索</el-button>
        <el-button icon="el-icon-refresh" @click="resetSearch">重置</el-button>
      </el-col>
    </el-row>
    <el-container class="log-table-container">
      <el-main>
        <el-table :data="logs" border stripe highlight-current-row @row-click="handleRowClick"
          style="width:100%; cursor:pointer;">
          <el-table-column type="index" label="序号" width="60" align="center" />
          <el-table-column prop="createTime" label="操作时间" width="160" sortable />
          <el-table-column prop="userName" label="操作用户" width="120" />
          <el-table-column prop="operation" label="操作描述" min-width="250" show-overflow-tooltip>
            <template slot-scope="scope">
              <span v-if="scope.row.operation.includes('【失败')" style="color:#f56c6c;">
                {{ scope.row.operation }}
              </span>
              <span v-else>{{ scope.row.operation }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="ip" label="IP地址" width="140" />
          <el-table-column prop="method" label="请求方法" width="220" show-overflow-tooltip />
        </el-table>
      </el-main>
    </el-container>

    <!-- 字段变更详情弹窗 -->
    <el-dialog title="字段变更详情" :visible.sync="snapshotVisible" width="600px">
      <el-table :data="snapshots" border stripe>
        <el-table-column prop="fieldName" label="字段名" width="150" />
        <el-table-column prop="oldValue" label="旧值" show-overflow-tooltip />
        <el-table-column prop="newValue" label="新值" show-overflow-tooltip />
      </el-table>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="snapshotVisible = false">关闭</el-button>
      </span>
    </el-dialog>

    <div class="page-container">
      <el-pagination background layout="total, sizes, prev, pager, next, jumper"
        :page-sizes="[5, 10, 30, 50, 100]" :page-size="page.pageSize" :total="total"
        :current-page="page.pageNum" @size-change="handlePageSizeChange" @current-change="handleCurrentPageChange">
      </el-pagination>
    </div>
  </div>
</template>

<script>
import { getOperationLogsApi, getOperationSnapshotApi } from "../../api/consumables/operationLog";

export default {
  name: "c_operationLog",
  data() {
    return {
      breadcrumbs: ["操作日志"],
      searchType: "3",
      searchStr: "",
      logs: [],
      total: 0,
      page: { pageNum: 1, pageSize: 30, searchCondition: null },
      snapshotVisible: false,
      snapshots: []
    };
  },
  mounted() {
    this.getInitData();
  },
  methods: {
    getInitData() {
      if (!this.page.searchCondition) {
        this.page.searchCondition = JSON.stringify({
          warehouseId: this.$store.state.curWarehouse.id
        });
      }
      getOperationLogsApi(this.page).then(res => {
        this.total = res.data.total;
        this.logs = res.data.list;
      });
    },
    doSearch() {
      this.page.searchCondition = JSON.stringify({
        searchType: this.searchType,
        searchStr: this.searchStr
      });
      this.page.pageNum = 1;
      this.getInitData();
    },
    resetSearch() {
      this.searchType = "3";
      this.searchStr = "";
      this.page.searchCondition = null;
      this.page.pageNum = 1;
      this.getInitData();
    },
    handlePageSizeChange(size) {
      this.page.pageSize = size;
      this.getInitData();
    },
    handleCurrentPageChange(currentPage) {
      this.page.pageNum = currentPage;
      this.getInitData();
    },
    handleRowClick(row) {
      getOperationSnapshotApi({ operationId: row.id }).then(res => {
        if (res.data && res.data.length > 0) {
          this.snapshots = res.data;
          this.snapshotVisible = true;
        } else {
          this.$message.info("该操作无字段变更记录");
        }
      });
    }
  }
};
</script>

<style scoped lang="less">
.operation-log-container { height: 100%; }
.operation-container { margin-bottom: 15px; }
.log-table-container { height: calc(100% - 130px); }
.page-container { margin-top: 15px; text-align: left; }
</style>