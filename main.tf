terraform {
  required_providers {
    // Здесь указываются все провайдеры, которые будут использоваться
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

// Terraform должен знать ключ, для выполнения команд по API

// Определение переменной, которую нужно будет задать
variable "do_token" {}
variable "datadog_api_key" {}
variable "datadog_app_key" {}

// Установка значения переменной
provider "digitalocean" {
  token = var.do_token
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = var.datadog_api_url
}



resource "digitalocean_droplet" "web" {
  name   = "web-nginx"
  size   = "s-1vcpu-1gb"
  image  = "nginx"
  region = "nyc3"
}

resource "digitalocean_droplet" "web2" {
  name   = "web-nginx2"
  size   = "s-1vcpu-1gb"
  image  = "nginx"
  region = "nyc3"
}

resource "digitalocean_loadbalancer" "public" {
  name   = "loadbalancer-1"
  region = "nyc3"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = [digitalocean_droplet.web.id, digitalocean_droplet.web2.id]
}
