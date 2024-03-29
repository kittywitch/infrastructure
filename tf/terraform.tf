terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.38.2"
    }
    tailscale = {
      source = "tailscale/tailscale"
      version = "0.13.7"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "4.4.0"
    }
  }

  cloud {
    organization = "kittywitch"
    ## Required for Terraform Enterprise; Defaults to app.terraform.io for Terraform Cloud
    hostname = "app.terraform.io"

    workspaces {
      name = "kittywitch"
    }
  }
}