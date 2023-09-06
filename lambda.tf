# Recurso para crear un archivo ZIP desde un directorio local
resource null_resource dummy_trigger {
  triggers = {
    timestamp = timestamp()
  }
}
data "archive_file" "zip_stg_pe_load_ticket_to_redshift_poc_test" {
  type        = "zip"
  source_dir  = "./lambda_scripts/ticket_to_redshift"
  output_path = "./lambda_scripts/ticket_to_redshift.zip"
  depends_on = [
    null_resource.dummy_trigger
  ]
}

resource "aws_lambda_function" "stg_pe_load_ticket_to_redshift_poc_test" {
  filename = data.archive_file.zip_stg_pe_load_ticket_to_redshift_poc_test.output_path
  function_name = "stg-pe-load-ticket-to-redshift-poc-prod"
  role          = "arn:aws:iam::704331390715:role/cl-mdh-test-etls-role"
  handler       = "index.lambda_handler"
  runtime       = "python3.7"
  timeout       = 900
  memory_size   = 2300
  layers        = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSDataWrangler-Python37:4"]
  vpc_config {
    subnet_ids         = local.subnet_ids
    security_group_ids = local.security_groups
  }
  ephemeral_storage {
    size = 2300 # Min 512 MB and the Max 10240 MB
  }
  environment {
    variables = {
      schema = "per_super_stg_ticket",
      secret_id = "test/user/redshift/cluster/ventas-poc-etl",
      table = "ticket"
    }
  }
  source_code_hash = data.archive_file.zip_stg_pe_load_ticket_to_redshift_poc_test.output_base64sha256
  tags = local.tags
}


data "archive_file" "zip_trigger_glue_job_lambda" {
  type        = "zip"
  source_file = "./lambda_scripts/trigger_glue_job/index.py"
  output_path = "./lambda_scripts/trigger_glue_job.zip"
  depends_on = [
    null_resource.dummy_trigger
  ]
}
resource "aws_lambda_function" "lambda_trigger_glue_job" {
  filename = data.archive_file.zip_trigger_glue_job_lambda.output_path
  function_name = "stg-pe-trigger-glue-job-poc-prod"
  role          = "arn:aws:iam::704331390715:role/cl-mdh-test-etls-role"
  handler       = "index.lambda_handler"
  runtime       = "python3.7"
  timeout       = 30
  memory_size   = 128
  ephemeral_storage {
    size = 512 # Min 512 MB and the Max 10240 MB
  }
  source_code_hash = data.archive_file.zip_trigger_glue_job_lambda.output_base64sha256
  tags = local.tags
}
