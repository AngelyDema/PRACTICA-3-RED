# main.tf
terraform {
  required_providers {
    google = { source = "hashicorp/google" }
  }
}

provider "google" {
  project = var.proyecto
  region  = var.region
}

# La VPC es global. En modo personalizado nace sin subredes.
resource "google_compute_network" "vpc" {
  name                    = "${var.prefijo}-vpc"
  auto_create_subnetworks = false
}

# La subred sí es regional, y es donde las máquinas toman su IP interna.
resource "google_compute_subnetwork" "publica" {
  name          = "${var.prefijo}-sub-publica"
  ip_cidr_range = var.cidr_publica
  region        = var.region
  network       = google_compute_network.vpc.id
}

resource "google_compute_instance" "app" {
  name         = "${var.prefijo}-app"
  machine_type = var.tipo_maquina
  zone         = var.zona
  tags         = ["servicio-web"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    # la máquina debe quedar en tu subred, no en la default
    subnetwork = google_compute_subnetwork.publica.self_link
    # un bloque vacío aquí otorga una IP pública efímera
    access_config {}
  }

  # La IP interna de la máquina de datos entra aquí. Esa referencia es lo
  # que hace que Terraform cree "datos" antes que "app": no hizo falta
  # escribir depends_on porque el valor ya aparece dentro del recurso.
  metadata_startup_script = templatefile("arranque.sh", {
    ip_datos = google_compute_instance.datos.network_interface[0].network_ip
  })
}

resource "google_compute_firewall" "app_http" {
  name    = "${var.prefijo}-permitir-http"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["servicio-web"]
}

resource "google_compute_firewall" "ssh_iap" {
  name    = "${var.prefijo}-permitir-ssh-iap"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # 35.235.240.0/20 es el rango desde el que Google reenvía SSH
  # a través de IAP. Es el único origen autorizado para el 22.
  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["servicio-web"]
}

# --- Fase 6: subred privada, máquina de datos y su salida sin entrada ---

# Otra subred, con otro rango, dentro de la misma VPC. Ninguna máquina
# aquí adentro va a tener dirección pública.
resource "google_compute_subnetwork" "privada" {
  name          = "${var.prefijo}-sub-privada"
  ip_cidr_range = var.cidr_privada
  region        = var.region
  network       = google_compute_network.vpc.id
}

# Sin bloque access_config: nace sin IP pública y no la va a tener nunca
# mientras el código siga así. Lo que no tiene dirección no se puede
# alcanzar desde fuera.
resource "google_compute_instance" "datos" {
  name         = "${var.prefijo}-datos"
  machine_type = var.tipo_maquina
  zone         = var.zona
  tags         = ["servicio-datos"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.privada.self_link
  }

  metadata_startup_script = file("arranque_datos.sh")
}

# Cloud Router: es el recurso que le da a un NAT algo donde apoyarse. No
# hace tráfico por sí mismo.
resource "google_compute_router" "router" {
  name    = "${var.prefijo}-router"
  region  = var.region
  network = google_compute_network.vpc.id
}

# Traduce la IP interna de la subred privada por una pública compartida,
# solo para el tráfico que sale. Nadie de fuera puede iniciar una
# conexión de vuelta: el NAT solo recuerda conversaciones que empezaron
# desde adentro.
resource "google_compute_router_nat" "nat" {
  name                               = "${var.prefijo}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.privada.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

# El origen es una etiqueta, no la red entera: solo la máquina de
# aplicación puede hablarle a la máquina de datos, y solo por el 80.
resource "google_compute_firewall" "datos_interno" {
  name    = "${var.prefijo}-permitir-datos-interno"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["servicio-web"]
  target_tags = ["servicio-datos"]
}