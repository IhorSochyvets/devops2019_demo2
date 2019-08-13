output "endpoint" {
  value = "${google_container_cluster.default1.endpoint}"
}

output "master_version" {
  value = "${google_container_cluster.default1.master_version}"
}
