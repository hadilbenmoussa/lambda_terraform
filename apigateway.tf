resource "aws_apigatewayv2_api" "notes_create" {
  name          = "apigw-http-lambda-notes-create"
  protocol_type = "HTTP"
  description   = "Serverlessland API Gwy HTTP API and AWS Lambda function"
}

resource "aws_apigatewayv2_integration" "create_integration" {
  api_id                 = aws_apigatewayv2_api.notes_create.id
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  integration_uri        = aws_lambda_function.notes-create.invoke_arn
  payload_format_version = "2.0"
}
resource "aws_apigatewayv2_stage" "create_dev" {
  api_id = aws_apigatewayv2_api.notes_create.id

  name        = "dev"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
  depends_on = [aws_cloudwatch_log_group.api_gw]
}



resource "aws_apigatewayv2_route" "create-route" {
  api_id    = aws_apigatewayv2_api.notes_create.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.create_integration.id}"
}



resource "aws_lambda_permission" "create_api_gw_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.notes-create.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.notes_create.execution_arn}/*/*"
}





resource "aws_apigatewayv2_api" "notes_get" {
  name          = "apigw-http-lambda-notes-get"
  protocol_type = "HTTP"
  description   = "Serverlessland API Gwy HTTP API and AWS Lambda function"
}


resource "aws_apigatewayv2_stage" "get_dev" {
  api_id = aws_apigatewayv2_api.notes_get.id

  name        = "dev"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
  depends_on = [aws_cloudwatch_log_group.api_gw]
}
resource "aws_apigatewayv2_integration" "get_integration" {
  api_id                 = aws_apigatewayv2_api.notes_get.id
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  integration_uri        = aws_lambda_function.notes-get.invoke_arn
  payload_format_version = "2.0"
}



resource "aws_apigatewayv2_route" "get-route" {
  api_id    = aws_apigatewayv2_api.notes_get.id
  route_key = "GET /notes"
  target    = "integrations/${aws_apigatewayv2_integration.get_integration.id}"
}



resource "aws_lambda_permission" "get_api_gw_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.notes-get.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.notes_get.execution_arn}/*/*"
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.notes_create.name}"

  retention_in_days = var.apigw_log_retention
}

resource "aws_apigatewayv2_api" "notes_delete" {
  name          = "apigw-http-lambda-notes-delete"
  protocol_type = "HTTP"
  description   = "Serverlessland API Gwy HTTP API and AWS Lambda function"
}

resource "aws_apigatewayv2_integration" "delete_integration" {
  api_id                 = aws_apigatewayv2_api.notes_delete.id
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  integration_uri        = aws_lambda_function.notes-delete.invoke_arn
  payload_format_version = "2.0"
}
resource "aws_apigatewayv2_stage" "delete_dev" {
  api_id = aws_apigatewayv2_api.notes_delete.id

  name        = "dev"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
  depends_on = [aws_cloudwatch_log_group.api_gw]
}



resource "aws_apigatewayv2_route" "delete-route" {
  api_id    = aws_apigatewayv2_api.notes_delete.id
  route_key = "DELETE /notes/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.delete_integration.id}"
}



resource "aws_lambda_permission" "delete_api_gw_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.notes-delete.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.notes_delete.execution_arn}/*/*"
}
