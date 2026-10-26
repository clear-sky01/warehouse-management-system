/**
 * 清空crush数据库脚本
 * 
 * 2020.03.10
 */
 
delete from application;
delete from application_detail;
delete from consumable;
delete from consumable_operation_detail;
delete from consumable_operation_history;
delete from consumable_reference_information;
delete from operation;
delete from permission;
delete from reference_information_template;
delete from reference_information_template_detail;
delete from role;
delete from role_permission;
delete from role_warehouse;
delete from type;
delete from type_warehouse;
delete from `user`;
delete from user_extension;
delete from user_permission;
delete from user_role;
delete from user_warehouse;
delete from warehouse;