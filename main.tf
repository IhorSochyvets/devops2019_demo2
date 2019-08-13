provider "google" {
  credentials = "${file("~/ssl_certs/k8s-test-249119-c7f7596653e7.json")}"
  project     = "k8s-test-249119"
  region      = "us-central1"
}


resource "google_container_cluster" "default1" {
  name        = "${var.name}"
  project     = "${var.project}"
  description = "Demo GKE Cluster"
  location    = "${var.location}"

  remove_default_node_pool = true
  initial_node_count = "${var.initial_node_count}"

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "default1" {
  name       = "${var.name}-node-pool"
  project     = "${var.project}"
  location   = "${var.location}"
  cluster    = "${google_container_cluster.default1.name}"
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "${var.machine_type}"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
