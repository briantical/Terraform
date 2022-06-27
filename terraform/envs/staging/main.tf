module "projects" {
  source = "../../modules/projects"

  do_token = var.do_token
  resources = concat( module.droplets.droplet_urns, tolist([module.balancers.balancer_urn]) )
  environment = var.environment
}

module "droplets" {
  source = "../../modules/droplets"

  do_token = var.do_token
  pvt_key = var.pvt_key
  pub_key = var.pub_key
  droplet_names = var.droplet_names
}

module "ansible" {
  source = "../../modules/ansible"

  do_token = var.do_token
  droplet_names = var.droplet_names
  droplets = module.droplets.droplets
  environment = var.environment
}

module "balancers" {
  source = "../../modules/balancers"

  do_token = var.do_token
  group_name = var.environment
  droplet_ids = module.droplets.droplet_ids
}
