resource "random_id" "suffix" {
  byte_length = 4
}
locals {
  suffix = random_id.suffix.hex
}
