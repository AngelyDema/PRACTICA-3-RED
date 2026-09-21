output "red" {
  value       = google_compute_network.vpc.name
  description = "Nombre de la VPC creada"
}

output "subred_publica" {
  value       = google_compute_subnetwork.publica.self_link
  description = "Identificador completo de la subred de aplicación"
}

output "ip_publica" {
  value = google_compute_instance.app.network_interface[0].access_config[0].nat_ip
}

output "ip_interna_datos" {
  value       = google_compute_instance.datos.network_interface[0].network_ip
  description = "IP interna de la máquina de datos. No tiene IP pública: esta es la única forma de dirigirse a ella."
}