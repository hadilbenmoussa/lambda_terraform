data "aws_dynamodb_table" "notes" {
  name = "notes"
}
data "aws_dynamodb_table" "users" {
  name = "users"
}

data "archive_file" "notes-get-archive" {
  source_file = "lambdas/notes-get.js"
  output_path = "lambdas/notes-get.zip"
  type        = "zip"
}

resource "aws_lambda_function" "notes-get" {
  environment {
    variables = {
      NOTES_TABLE = data.aws_dynamodb_table.notes.name
    }
  }
  memory_size   = "128"
  timeout       = 10
  runtime       = "nodejs14.x"
  architectures = ["arm64"]
  handler       = "lambdas/notes-get.handler"
  function_name = "notes-get"
  role          = aws_iam_role.iam_for_lambda.arn
  filename      = "lambdas/notes-get.zip"
}
data "archive_file" "notes-create-archive" {
  source_file = "lambdas/notes-create.js"
  output_path = "lambdas/notes-create.zip"
  type        = "zip"
}

resource "aws_lambda_function" "notes-create" {
  environment {
    variables = {
      NOTES_TABLE = data.aws_dynamodb_table.notes.name
    }
  }
  memory_size   = "128"
  timeout       = 10
  runtime       = "nodejs14.x"
  architectures = ["arm64"]
  handler       = "lambdas/notes-create.handler"
  function_name = "notes-create"
  role          = aws_iam_role.iam_for_lambda.arn
  filename      = "lambdas/notes-create.zip"
}

data "archive_file" "notes-delete-archive" {
  source_file = "lambdas/notes-delete.js"
  output_path = "lambdas/notes-delete.zip"
  type        = "zip"
}

resource "aws_lambda_function" "notes-delete" {
  environment {
    variables = {
      NOTES_TABLE = data.aws_dynamodb_table.notes.name
    }
  }
  memory_size   = "128"
  timeout       = 10
  runtime       = "nodejs14.x"
  architectures = ["arm64"]
  handler       = "lambdas/notes-delete.handler"
  function_name = "notes-delete"
  role          = aws_iam_role.iam_for_lambda.arn
  filename      = "lambdas/notes-delete.zip"
}

