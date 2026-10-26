# 仓库消耗品管理系统

一个基于 Spring Boot + MyBatis + Shiro/JWT + Vue 2 + Element UI 的前后端分离教学项目，覆盖用户登录、角色权限、仓库管理、消耗品分类、库存入库出库、申请审批、操作日志和统计查询等典型后台管理系统能力。

## 技术栈

- 后端：Spring Boot 2.2.2、MyBatis、Shiro、JWT、Druid、Swagger、PageHelper、Apache POI
- 前端：Vue 2、Vue Router、Vuex、Element UI、Axios、ECharts
- 数据库与中间件：MySQL、Redis
- 构建工具：Maven、npm、Vue CLI

## 核心功能

- 认证授权：账号登录、JWT 鉴权、Shiro 权限拦截、角色权限初始化
- 用户与角色：用户新增、编辑、启停、导入导出、角色权限配置
- 仓库管理：仓库资料维护、仓库管理员关联、仓库状态管理
- 消耗品管理：消耗品分类、物资资料、入库、出库、库存状态维护
- 申请系统：消耗品申请、申请状态流转、申请记录查询
- 操作日志：基于注解和切面记录关键业务操作
- 数据统计：库存、出入库、用户操作等统计查询与导出

## 项目结构

```text
.
├── Server/frame                 # Spring Boot 后端
│   ├── src/main/java/frame/server
│   │   ├── controller           # 接口层
│   │   ├── service              # 业务层
│   │   ├── dao                  # MyBatis DAO
│   │   ├── domain               # 数据库实体
│   │   ├── dto                  # 数据传输对象
│   │   ├── vo                   # 请求/响应模型
│   │   ├── config               # Shiro、JWT、MyBatis、Swagger 配置
│   │   └── aspect               # 操作日志切面
│   └── src/main/resources
│       └── 数据库脚本/crush.sql
├── Web/frame                    # Vue 前端
└── dev-env                      # 本地开发环境脚本
```

## 一键本地部署

首次运行或演示时，在项目根目录执行：

```bash
cd "/Users/cline/Desktop/java 实训/第一天/代码/仓库消耗品管理系统"
chmod +x dev-env/*.sh
./dev-env/deploy-local.sh
```

脚本会自动完成：

- 初始化 MySQL 数据库 `crush`
- 启动 Spring Boot 后端
- 初始化角色、权限、用户等基础数据
- 安装前端依赖
- 启动 Vue 前端

停止服务：

```bash
./dev-env/stop-local.sh
```

默认访问地址：

- 前端：`http://localhost:8889`
- Swagger：`http://127.0.0.1:8888/swagger-ui.html`

默认初始化账号：

```text
账号：kmgzs0713@163.com
密码：xA123456
```

## 适合教学讲解的模块

- 从 `LoginController` 到 `JwtFilter` 讲登录认证与 token 校验。
- 从 `CRoleController`、`RoleDao`、`Permission` 讲 RBAC 权限模型。
- 从 `CConsumableController` 讲典型 CRUD、分页、导入导出。
- 从 `OperationAnnotation` 与 `OperationAspect` 讲 AOP 操作日志。
- 从 `crush.sql` 讲业务表设计和模块关系。

## 说明

该项目用于 Java Web/Spring Boot 入门教学和项目经验展示。仓库中不提交本地构建产物、依赖目录和敏感配置；数据库、邮箱等配置支持通过环境变量覆盖。
