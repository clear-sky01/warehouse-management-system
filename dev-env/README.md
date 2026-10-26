# Spring Boot 教学项目开发环境

## 项目组成

- 后端：`Server/frame`
- 前端：`Web/frame`
- 数据库脚本：`Server/frame/src/main/resources/数据库脚本/crush.sql`

## 本机依赖

- Java 8/11/17 优先。当前项目是 Spring Boot 2.2.x，过新的 JDK 可能存在兼容性问题。
- Maven 3.x
- MySQL 5.7/8.x
- Redis 可选，完整教学建议启动。
- Node.js。前端是 Vue 2 + Vue CLI 4，建议 Node 14/16；新版本 Node 需要 `NODE_OPTIONS=--openssl-legacy-provider`。

## 初始化数据库

## 一键本地部署

```bash
cd "/Users/cline/Desktop/java 实训/第一天/代码/仓库消耗品管理系统"
chmod +x dev-env/*.sh
./dev-env/deploy-local.sh
```

停止服务：

```bash
./dev-env/stop-local.sh
```

一键部署脚本会依次初始化数据库、启动后端、初始化基础数据、安装前端依赖并启动前端。

## 手动初始化数据库

默认连接本机 MySQL：`127.0.0.1:3306`，用户 `root`，密码 `123456`。

```bash
cd "/Users/cline/Desktop/java 实训/第一天/代码/仓库消耗品管理系统"
chmod +x dev-env/*.sh
./dev-env/init-db.sh
```

如果你的 MySQL 密码不是 `123456`：

```bash
MYSQL_USER=root MYSQL_PASSWORD=你的密码 ./dev-env/init-db.sh
```

## 启动后端

```bash
cd "/Users/cline/Desktop/java 实训/第一天/代码/仓库消耗品管理系统"
./dev-env/start-backend.sh
```

后端默认端口：`8888`

如果数据库账号不同：

```bash
DB_USERNAME=root DB_PASSWORD=你的密码 ./dev-env/start-backend.sh
```

## 初始化应用基础数据

后端启动成功后，另开一个终端执行：

```bash
cd "/Users/cline/Desktop/java 实训/第一天/代码/仓库消耗品管理系统"
./dev-env/init-app-data.sh
```

这些接口会初始化权限、角色、用户、用户角色关系、用户权限关系和基准信息模板。

## 启动前端

首次启动前需要安装依赖：

```bash
cd "/Users/cline/Desktop/java 实训/第一天/代码/仓库消耗品管理系统/Web/frame"
npm install --legacy-peer-deps --package-lock=false --registry=https://registry.npmjs.org
```

启动：

```bash
cd "/Users/cline/Desktop/java 实训/第一天/代码/仓库消耗品管理系统"
./dev-env/start-frontend.sh
```

前端默认地址为：`http://localhost:8889`

## 教学建议

建议按这个顺序讲：

1. 先看项目整体目录：`Server/frame` 和 `Web/frame`。
2. 再看后端分层：`controller`、`service`、`dao`、`domain`、`vo`、`dto`。
3. 讲登录流程：`LoginController`、`JwtFilter`、`JwtUtil`、`ShiroConfig`。
4. 讲一个业务模块：`CConsumableController` 对应消耗品管理。
5. 讲一个扩展点：`OperationAnnotation` + `OperationAspect` 实现操作日志。
