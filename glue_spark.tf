# resource "aws_s3_bucket_object" "script_spark_minibatch_etl" {
#   bucket = "cenco-pe-poc-ventas"
#   key = "etls_scripts/mini_batch_etl.py" 
#   source = "./etls_scripts/mini_batch_etl.py" 

#   etag = filemd5("./etls_scripts/mini_batch_etl.py") 
# }

# resource "aws_glue_job" "etl-spark-job-minibatch-etl" {
#   name     = "stg-pe-mini-batch-tickets-process-prod-poc"
#   role_arn = "arn:aws:iam::704331390715:role/cl-mdh-test-etls-role"
#   number_of_workers = 2
#   worker_type = "G.2X"
#   max_retries = "0"
#   timeout = "3600"
#   glue_version = "4.0"
#   connections = "${var.connections}"
#   command {
#     name = "glueetl"
#     python_version = 3
#     script_location = "s3://cenco-pe-poc-ventas/etls_scripts/mini_batch_etl.py"
#   }
#   execution_property {
#     max_concurrent_runs = 30
#   }
#   # default_arguments = {
#   #   "--extra-jars" = "s3://cencosud-desa-cl-artefacts-innovacion/artefacts/helpers/dremio-jdbc-driver-24.0.0-202302100528110223-3a169b7c.jar"
#   #   "--job-bookmark-option"   = "job-bookmark-enable"
#   # }
#   tags = local.tags
# }
