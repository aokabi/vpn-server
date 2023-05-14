# Define required providers
terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.48.0"
    }
  }
	backend "local" {
		path = "sv-vRUB8tJo9gQ9rSut.tfstate"
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
	name            = "160-251-106-170"
	image_id        = "e0e17ed7-d1a9-44af-9d20-9931521b05f3" # ubuntu
	flavor_id       = "ab7b9b6d-108c-4487-90a4-2da604ad6a92"
	security_groups = ["default"]
	network {
		port = "{openstack_networking_portv2.port_vpn_2.id}"
	}
	metadata = {
		"instance_name_tag" = "vpn-2"
	}
}

resource "openstack_networking_network_v2" "network_vpn_2" {
  name           = "network_vpn_2"
  admin_state_up = "true"
}

resource "openstack_networking_port_v2" "port_vpn_2" {
	name       = "port_vpn_2"
	network_id = "{openstack_networking_network_v2.network_vpn_2.id}"
  admin_state_up = "true"
	security_group_ids = [
		"4815010e-def7-4c61-85a2-a4ae68d4c158",  # default
		"3cde2a8e-85c2-4a09-b2bd-016939f073c4"  # gncs-ipv4-ssh
		]
}
