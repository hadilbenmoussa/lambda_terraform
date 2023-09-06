output "create_apigwy_url" {
  description = "URL for API Gateway stage"

  value = aws_apigatewayv2_api.notes_create.api_endpoint
}
output "get_apigwy_url" {
  description = "URL for API Gateway stage"

  value = aws_apigatewayv2_api.notes_get.api_endpoint
}
output "delete_apigwy_url" {
  description = "URL for API Gateway stage"

  value = aws_apigatewayv2_api.notes_delete.api_endpoint
}


