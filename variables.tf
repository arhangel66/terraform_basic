

variable "datadog_api_url" {
  description = "api url for datadog"
  // Тип значения переменной
  type        = string
  // Значение по умолчанию, которое используется если не задано другое
  default = "https://api.datadoghq.eu/"
  sensitive = false
}