variable vpc_id {}
variable zone_id {}
variable key_name {}
variable ebs_disks {}
variable account_id {}
variable logdna_key {}
variable aws_lb_arn {}
variable aws_region {}
variable ecr_region {}
variable cluster_sg {}
variable name_prefix {}
variable wm_instance {}
variable environment {}
variable domain_name {}
variable ecs_subnets {}
variable standard_tags {}
variable ecr_account_id {}
variable public_subnets {}
variable service_config {}
variable instance_types {}
variable security_groups {}
variable private_subnets {}
variable container_insights {}
variable access_logs_s3_bucket {}
variable aws_lb_certificate_arn {}

variable protect_from_scale_in {}
variable force_delete {}

variable desired_count {
    type    = number
    default = 1
}
