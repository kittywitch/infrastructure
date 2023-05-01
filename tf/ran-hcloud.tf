resource "hcloud_primary_ip" "ran_ipv4" {
	auto_delete = false
	name = "ran-v4"
	datacenter = "hil-dc1"
	type = "ipv4"
	assignee_type = "server"
}


resource "hcloud_primary_ip" "ran_ipv6" {
	auto_delete = false
	name = "ran-v6"
	datacenter = "hil-dc1"
	type = "ipv6"
	assignee_type = "server"
}
resource "hcloud_server" "ran" {
    name = "ran"
    server_type = "cpx21"
    keep_disk = true
    allow_deprecated_images = false
    image = "ubuntu-22.04"
    datacenter = "hil-dc1"
    public_net {
        ipv4_enabled = true
        ipv4 = hcloud_primary_ip.ran_ipv4.id
        ipv6_enabled = true
        ipv6 = hcloud_primary_ip.ran_ipv6.id
    }

    lifecycle {
        ignore_changes = [
            user_data,
            public_net
        ]
    }
}


resource "hcloud_rdns" "ran-v4" {
    server_id  = hcloud_server.ran.id
    ip_address = hcloud_server.ran.ipv4_address
    dns_ptr    = "ran.gensokyo.zone"
}

resource "hcloud_rdns" "ran-v6" {
    server_id  = hcloud_server.ran.id
    ip_address = hcloud_server.ran.ipv6_address
    dns_ptr    = "ran.gensokyo.zone"
}