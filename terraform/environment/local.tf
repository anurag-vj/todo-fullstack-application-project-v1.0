locals {
  environment = "dev"
  application = "practice"
  location    = "central india"
  name_prefix = "${local.environment}-${local.application}"
  common_tags = {
    "environment" = local.environment
    "owner"       = "devops-team"
    "project"     = "devops-practice"
    "application" = local.application
  }
}
