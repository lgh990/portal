CREATE TABLE IF NOT EXISTS SH_LEAGUE_CONTACT_TEAM_ROLE(ROLE_NAME VARCHAR NOT NULL,
TEAM_ID INT NOT NULL,
CONTACT_ID INT NOT NULL,
PRIMARY KEY(TEAM_ID, CONTACT_ID));

CREATE TABLE IF NOT EXISTS apigw_envoy_health_check_rule (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_time bigint NOT NULL,
  update_time bigint NOT NULL,
  service_id bigint NOT NULL,
  gw_id bigint NOT NULL,
  active_switch tinyint NOT NULL,
  path varchar(255) DEFAULT '',
  timeout int DEFAULT NULL,
  expected_statuses varchar(255) DEFAULT '',
  healthy_interval int DEFAULT NULL,
  healthy_threshold int DEFAULT NULL,
  unhealthy_interval int DEFAULT NULL,
  unhealthy_threshold int DEFAULT NULL,
  passive_switch tinyint NOT NULL,
  consecutive_errors int DEFAULT NULL,
  base_ejection_time int DEFAULT NULL,
  max_ejection_percent tinyint DEFAULT NULL,
  min_health_percent tinyint DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT unique_service_gw_id
    UNIQUE (
      service_id,
      gw_id
    )
);

CREATE INDEX IF NOT EXISTS index_service_gw_id ON apigw_envoy_health_check_rule(service_id, gw_id);

CREATE TABLE IF NOT EXISTS apigw_envoy_plugin_binding (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  plugin_type varchar(255) NOT NULL,
  binding_object_type varchar(255) NOT NULL,
  binding_object_id varchar(255) NOT NULL,
  plugin_configuration clob NOT NULL,
  create_time bigint NOT NULL,
  update_time bigint NOT NULL,
  gw_id bigint NOT NULL,
  project_id bigint NOT NULL,
  plugin_priority bigint NOT NULL,
  binding_status varchar(127) NOT NULL DEFAULT 'enable',
  template_id bigint DEFAULT '0',
  template_version bigint DEFAULT '0',
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_envoy_plugin_info (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  plugin_name varchar(255) NOT NULL,
  plugin_type varchar(255) NOT NULL,
  author varchar(255) NOT NULL,
  create_time bigint NOT NULL,
  update_time bigint NOT NULL,
  plugin_scope varchar(255) NOT NULL,
  instruction_for_use clob NOT NULL,
  plugin_schema clob NOT NULL,
  plugin_handler clob NOT NULL,
  plugin_priority bigint NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_envoy_plugin_template (
  id number NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_time bigint NOT NULL,
  update_time bigint NOT NULL,
  plugin_type varchar(255) NOT NULL,
  plugin_configuration clob NOT NULL,
  project_id bigint NOT NULL,
  template_version bigint NOT NULL,
  template_name varchar(255) NOT NULL,
  template_notes varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_envoy_route_rule (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  service_id varchar(11) DEFAULT NULL,
  route_rule_name varchar(255) NOT NULL,
  uri clob,
  method varchar(1024) DEFAULT NULL,
  header clob,
  query_param clob,
  host varchar(1024) DEFAULT NULL,
  priority bigint DEFAULT NULL,
  orders bigint DEFAULT NULL,
  project_id bigint DEFAULT NULL,
  publish_status int DEFAULT '0',
  create_time bigint NOT NULL DEFAULT '0',
  update_time bigint NOT NULL DEFAULT '0',
  description varchar(255) DEFAULT NULL,
  route_rule_source varchar(255) DEFAULT NULL,
  header_operation varchar(1024) DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_envoy_route_rule_proxy (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  route_rule_id bigint NOT NULL,
  gw_id bigint NOT NULL,
  destination_services varchar(1024) NOT NULL,
  project_id bigint NOT NULL,
  priority bigint DEFAULT NULL,
  orders bigint DEFAULT NULL,
  create_time bigint NOT NULL DEFAULT '0',
  update_time bigint NOT NULL DEFAULT '0',
  service_id bigint DEFAULT NULL,
  enable_state varchar(10) NOT NULL DEFAULT 'enable',
  hosts clob,
  timeout bigint DEFAULT '60000',
  http_retry clob,
  uri varchar(1024) DEFAULT NULL,
  method varchar(1024) DEFAULT NULL,
  header clob,
  query_param clob,
  host varchar(1024) DEFAULT NULL,
  virtual_cluster clob DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_gw_id ON apigw_envoy_route_rule_proxy (gw_id);
CREATE INDEX IF NOT EXISTS idx_route_rule_id ON apigw_envoy_route_rule_proxy (route_rule_id);

CREATE TABLE IF NOT EXISTS apigw_envoy_service_info (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_time bigint DEFAULT NULL,
  update_time bigint DEFAULT NULL,
  service_name varchar(255) NOT NULL,
  publish_status int DEFAULT '0',
  project_id bigint DEFAULT NULL,
  contact varchar(255) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  service_type varchar(11) DEFAULT 'http',
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS apigw_envoy_service_proxy (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  service_id bigint NOT NULL,
  create_time bigint DEFAULT NULL,
  update_time bigint DEFAULT NULL,
  code varchar(255) NOT NULL,
  publish_protocol varchar(10) DEFAULT 'http',
  backend_service clob,
  publish_type varchar(255) DEFAULT NULL,
  project_id bigint DEFAULT '0',
  gw_id bigint NOT NULL,
  load_balancer varchar(127) NOT NULL DEFAULT 'ROUND_ROBIN',
  subsets clob,
  registry_center_addr varchar(255) DEFAULT NULL,
  registry_center_type varchar(255) DEFAULT NULL,
  traffic_policy clob,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_envoy_strategy (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  plugin_id bigint NOT NULL,
  plugin_type varchar(255) NOT NULL,
  strategy_name varchar(255) NOT NULL,
  create_time bigint NOT NULL,
  update_time bigint NOT NULL,
  config clob NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_envoy_virtual_host_info (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  project_id bigint NOT NULL,
  gw_id bigint NOT NULL,
  hosts clob,
  virtual_host_code varchar(255) NOT NULL,
  create_time bigint NOT NULL,
  update_time bigint NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_api (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  api_name varchar(255) NOT NULL,
  api_path varchar(255) NOT NULL,
  api_method varchar(255) NOT NULL,
  description clob,
  type varchar(255) NOT NULL,
  service_id bigint NOT NULL,
  status varchar(255) NOT NULL DEFAULT '0',
  regex varchar(255) DEFAULT NULL,
  document_status_id bigint DEFAULT '0',
  request_example_value clob,
  response_example_value clob,
  alias_name varchar(128) DEFAULT NULL,
  project_id bigint DEFAULT NULL,
  sync_status tinyint DEFAULT '0',
  ext_api_id bigint DEFAULT NULL,
  swagger_sync tinyint DEFAULT '0',
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS apigw_gportal_api_document_status (
  id bigint NOT NULL AUTO_INCREMENT,
  status varchar(255) NOT NULL,
  PRIMARY KEY (id, status)
);

CREATE TABLE IF NOT EXISTS apigw_gportal_api_model (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  model_name varchar(255) NOT NULL,
  description varchar(255) DEFAULT NULL,
  type tinyint DEFAULT NULL,
  format tinyint DEFAULT NULL,
  service_id bigint NOT NULL,
  swagger_sync tinyint DEFAULT '0',
  project_id bigint DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS index_model_id ON apigw_gportal_api_model(id);

CREATE TABLE IF NOT EXISTS apigw_gportal_api_proxy (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint NOT NULL,
  modify_date bigint DEFAULT NULL,
  api_id bigint NOT NULL,
  gw_id bigint NOT NULL,
  service_id bigint DEFAULT NULL,
  traffic_control_policy_id bigint DEFAULT '0',
  time_range varchar(255) DEFAULT NULL,
  project_id bigint DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_api_status_code (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  error_code varchar(255) DEFAULT NULL,
  message varchar(255) DEFAULT NULL,
  status_code bigint DEFAULT NULL,
  object_id bigint DEFAULT NULL,
  type varchar(255) NOT NULL,
  description clob,
  PRIMARY KEY (id)
  );
CREATE INDEX IF NOT EXISTS index_api_id ON apigw_gportal_api_status_code(object_id);

CREATE TABLE IF NOT EXISTS apigw_gportal_body_param (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  api_id bigint NOT NULL,
  param_name varchar(255) NOT NULL,
  required varchar(20) NOT NULL DEFAULT '0',
  def_value varchar(255) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  type varchar(255) NOT NULL,
  param_type_id bigint DEFAULT NULL,
  array_data_type_id bigint DEFAULT NULL,
  association_type varchar(63) DEFAULT 'NORMAL',
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS apigw_gportal_gateway_info (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  gw_name varchar(255) NOT NULL,
  gw_addr varchar(255) NOT NULL,
  description varchar(255) DEFAULT NULL,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  last_check_time bigint DEFAULT '0',
  project_id bigint NOT NULL,
  gw_uni_id varchar(128) DEFAULT NULL,
  api_plane_addr varchar(255) DEFAULT NULL,
  gw_cluster_name varchar(255) DEFAULT NULL,
  gw_type varchar(20) DEFAULT 'envoy',
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_header_param (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  api_id bigint NOT NULL,
  param_name varchar(255) NOT NULL,
  param_value varchar(255) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  type varchar(255) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_meta_history (
  id bigint NOT NULL,
  meta_type varchar(255) NOT NULL,
  meta_id bigint NOT NULL,
  meta_name varchar(255) NOT NULL,
  meta_tag varchar(255) NOT NULL,
  project_id bigint NOT NULL,
  gw_id bigint NOT NULL,
  parent_id bigint DEFAULT NULL,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_model_param (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  model_id varchar(255) NOT NULL,
  param_name varchar(255) NOT NULL,
  param_type_id bigint NOT NULL,
  array_data_type_id bigint DEFAULT NULL,
  object_id bigint DEFAULT NULL,
  def_value varchar(255) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  required varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS index_model_param_id ON apigw_gportal_model_param(id);

CREATE TABLE IF NOT EXISTS apigw_gportal_operation_log (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  email varchar(255) DEFAULT NULL,
  object_id bigint DEFAULT NULL,
  operation clob,
  type varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS index_object_id ON apigw_gportal_operation_log(object_id, type);

CREATE TABLE IF NOT EXISTS apigw_gportal_param_object (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  object_value varchar(1024) DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS index_param_object_id ON apigw_gportal_param_object(id);

CREATE TABLE IF NOT EXISTS apigw_gportal_param_type (
  id bigint NOT NULL AUTO_INCREMENT,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  param_type varchar(255) NOT NULL,
  location varchar(255) NOT NULL,
  model_id bigint DEFAULT '0',
  PRIMARY KEY (
    id,
    param_type
  )
);
CREATE TABLE IF NOT EXISTS apigw_gportal_plugin (
  id number NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  gw_id bigint DEFAULT NULL,
  plugin_name varchar(255) DEFAULT NULL,
  plugin_version varchar(255) DEFAULT NULL,
  plugin_file_name varchar(255) DEFAULT NULL,
  plugin_content clob,
  plugin_variable clob,
  plugin_status int DEFAULT NULL,
  last_start_time bigint DEFAULT NULL,
  plugin_starting_time bigint DEFAULT NULL,
  plugin_call_number bigint DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_registry_center (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  registry_type varchar(255) NOT NULL,
  registry_addr varchar(255) NOT NULL,
  registry_alias varchar(255) DEFAULT NULL,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  project_id bigint DEFAULT NULL,
  is_shared tinyint DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_service (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  display_name varchar(255) NOT NULL,
  service_name varchar(255) DEFAULT NULL,
  contacts varchar(255) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  status int NOT NULL DEFAULT '0',
  health_interface_path varchar(255) DEFAULT NULL,
  service_type varchar(63) DEFAULT NULL,
  project_id bigint DEFAULT NULL,
  sync_status tinyint DEFAULT '0',
  ext_service_id bigint DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_service_instance (
  id number NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  service_id bigint NOT NULL,
  gw_id bigint NOT NULL,
  service_addr varchar(255) DEFAULT NULL,
  status bigint NOT NULL DEFAULT '1',
  last_check_time bigint NOT NULL DEFAULT '0',
  registry_center_addr varchar(511) DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_service_lb (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  service_id bigint DEFAULT NULL,
  gw_id bigint DEFAULT NULL,
  service_addr varchar(255) NOT NULL,
  weight int NOT NULL,
  status int DEFAULT '1',
  last_check_time bigint DEFAULT '0',
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_service_lb_rule (
  id number NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  service_id bigint NOT NULL,
  gw_id bigint NOT NULL,
  shunt_way varchar(255) NOT NULL DEFAULT '',
  instance_weight_list clob,
  param_shunt_type varchar(255) DEFAULT '',
  param_type varchar(255) DEFAULT '',
  param_name varchar(255) DEFAULT '',
  modulus_threshold int DEFAULT NULL,
  item_list clob,
  regex int DEFAULT NULL,
  instance_list clob,
  rule_name varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_service_lb_rule_binding (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  rule_id bigint NOT NULL,
  gw_id bigint NOT NULL,
  service_id bigint NOT NULL,
  binding_time bigint NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_service_lb_rule_multi (
  id number NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  service_id bigint NOT NULL,
  rule_name varchar(255) DEFAULT NULL,
  shunt_way varchar(255) DEFAULT NULL,
  param_matching_mode varchar(255) DEFAULT NULL,
  param_type varchar(255) DEFAULT NULL,
  param_name varchar(255) DEFAULT NULL,
  instance_type varchar(255) DEFAULT NULL,
  instance_list clob,
  color varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS index_service_id ON apigw_gportal_service_lb_rule_multi(service_id);

CREATE TABLE IF NOT EXISTS apigw_gportal_service_protobuf (
  id number NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  service_id number NOT NULL,
  pb_name varchar(255) NOT NULL DEFAULT '',
  pb_file_name varchar(255) NOT NULL DEFAULT '',
  pb_file_content clob NOT NULL,
  desc_file_content clob NOT NULL,
  description varchar(255) DEFAULT NULL,
  pb_status int NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_service_id ON apigw_gportal_service_protobuf(service_id);
CREATE INDEX IF NOT EXISTS index_pb_name ON apigw_gportal_service_protobuf(pb_name);

CREATE TABLE IF NOT EXISTS apigw_gportal_service_protobuf_proxy (
  id number NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint DEFAULT NULL,
  modify_date bigint DEFAULT NULL,
  pb_id bigint NOT NULL,
  gw_id bigint NOT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS index_pb_id ON apigw_gportal_service_protobuf_proxy(pb_id);

CREATE TABLE IF NOT EXISTS apigw_gportal_service_proxy (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  create_date bigint NOT NULL,
  modify_date bigint DEFAULT NULL,
  service_id bigint NOT NULL,
  gw_id bigint NOT NULL,
  service_addr clob,
  time_range varchar(255) DEFAULT NULL,
  class_name varchar(255) DEFAULT NULL,
  flow_replication_addr varchar(255) DEFAULT NULL,
  authentication tinyint DEFAULT '1',
  shunt_way varchar(255) DEFAULT NULL,
  shunt_switch int DEFAULT '0',
  project_id bigint DEFAULT NULL,
  addr_acquire_strategy varchar(64) DEFAULT NULL,
  registry_center_addr varchar(255) DEFAULT NULL,
  application_name varchar(255) DEFAULT NULL,
  transparent tinyint DEFAULT '0',
  custom_header varchar(4000) DEFAULT NULL,
  registry_center_type varchar(255) DEFAULT NULL,
  adapt_service_name int DEFAULT '0',
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_traffic_control_binding (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  api_id bigint NOT NULL,
  policy_id bigint NOT NULL,
  binding_time bigint NOT NULL,
  gw_id bigint NOT NULL,
  gateway_name varchar(128) NOT NULL DEFAULT '',
  policy_name varchar(128) NOT NULL DEFAULT '',
  project_id varchar(20) DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_api_id ON apigw_gportal_traffic_control_binding(api_id);
CREATE INDEX IF NOT EXISTS idx_policy_id ON apigw_gportal_traffic_control_binding(policy_id);

CREATE TABLE IF NOT EXISTS apigw_gportal_traffic_control_dimension (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  traffic_control_policy_id bigint NOT NULL,
  slot bigint NOT NULL,
  unit varchar(128) NOT NULL,
  dimension_limit bigint NOT NULL,
  capacity bigint NOT NULL,
  dimension_type varchar(64) NOT NULL,
  param_name varchar(128) DEFAULT NULL,
  match_mode varchar(128) DEFAULT NULL,
  param_value varchar(2048) DEFAULT NULL,
  PRIMARY KEY (id)
  );
CREATE INDEX IF NOT EXISTS idx_traffic_control_policy_id ON apigw_gportal_traffic_control_dimension(traffic_control_policy_id);

CREATE TABLE IF NOT EXISTS apigw_gportal_traffic_control_policy (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  name varchar(128) NOT NULL,
  create_time bigint NOT NULL,
  update_time bigint NOT NULL,
  project_id varchar(20) DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_white_list (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  policy_name varchar(127) NOT NULL DEFAULT '',
  policy_type varchar(63) NOT NULL DEFAULT '',
  white_list clob NOT NULL,
  create_time bigint NOT NULL DEFAULT '0',
  update_time bigint NOT NULL DEFAULT '0',
  project_id varchar(127) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS apigw_gportal_white_list_binding (
  id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  gw_id bigint NOT NULL,
  policy_id bigint NOT NULL DEFAULT '0',
  binding_time bigint NOT NULL DEFAULT '0',
  binding_object_id varchar(127) NOT NULL DEFAULT '',
  binding_object_type varchar(63) NOT NULL DEFAULT '',
  project_id varchar(127) NOT NULL,
  policy_name varchar(127) NOT NULL DEFAULT '',
  binding_object_name varchar(127) NOT NULL DEFAULT '',
  PRIMARY KEY (id)
);