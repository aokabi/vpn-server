# Define required providers
terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.48.0"
    }
  }
}

# openstack provider
provider "openstack" {
	user_name   = "gncu39420955"
	tenant_name = "gnct39420955"
	auth_url    = "https://identity.tyo1.conoha.io/v2.0"
}

# openstack security_group
#resource "openstack_compute_secgroup_v2" "wireguard" {
#	name        = "wireguard"
#	description = "wireguard port"
#	rule {
#		from_port   = 51820 
#		to_port     = 51820
#		ip_protocol = "udp"
#		ip_range    = "0.0.0.0/0"
#	}
#}

# openstack instance
resource "openstack_compute_instance_v2" "vpn-2" {
	name            = "vpn-2"
	image_id        = "vmi-debian-11.0-amd64-100gb" # ubuntu
	flavor_id       = "ab7b9b6d-108c-4487-90a4-2da604ad6a92"
	security_groups = ["default"]
}