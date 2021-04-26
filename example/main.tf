provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "vmware-sdwan" {
  source               = "equinix/vmware-sdwan/equinix"
  version              = "1.0.0"
  name                 = "tf-vmware-sdwan"
  metro_code           = var.metro_code_primary
  platform             = "medium"
  software_package     = "VeloCloud-4"
  term_length          = 1
  notifications        = ["test@test.com"]
  additional_bandwidth = 100
  acl_template_id      = equinix_network_acl_template.vmware-pri.id
  activation_key       = "AAAA-BBBB-CCCC-DDDD"
  controller_fqdn      = "test.com"
  secondary = {
    enabled              = true
    metro_code           = var.metro_code_secondary
    additional_bandwidth = 100
    acl_template_id      = equinix_network_acl_template.vmware-sec.id
    activation_key       = "DDDD-EEEE-FFFF-GGGG"
    controller_fqdn      = "test2.com"
  }
}

resource "equinix_network_acl_template" "vmware-pri" {
  name        = "tf-vmware-pri"
  description = "Primary VMWare SD-WAN ACL template"
  metro_code  = var.metro_code_primary
  inbound_rule {
    subnets  = ["193.39.0.0/16", "12.16.103.0/24"]
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}

resource "equinix_network_acl_template" "vmware-sec" {
  name        = "tf-vmware-sec"
  description = "Secondary VMWare SD-WAN ACL template"
  metro_code  = var.metro_code_secondary
  inbound_rule {
    subnets  = ["193.39.0.0/16", "12.16.103.0/24"]
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
