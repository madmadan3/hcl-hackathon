resource "aws_ecr_repository" "main" {
  name = var.repository_name
}

output "repository_url" {
  value = aws_ecr_repository.main.repository_url
}
