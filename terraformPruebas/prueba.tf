resource "local_file" "pruebas" {
    filename = "/Users/hugodiazgarcia/Proyectos/TFM/terraform/conjunto-pruebas"
    content = "Es un recurso de prueba en terraform"
    file_permission = "0700"
}