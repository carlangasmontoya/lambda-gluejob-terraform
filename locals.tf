locals {
  tags = {
    "Name"        = "BI - Venta en Linea - Glue"
    "ambiente"    = "test"
    "aplicacion"  = "BI - Venta en Linea"
    "area"        = "Int. Negocio"
    "ceco"        = "pgo1007383"
    "cuenta"      = "181398079618"
    "nombre"      = "BI - Venta en Linea - Glue"
    "pais"        = "pe"
    "plataforma"  = "linux"
    "propietario" = "erick.castro@cencosud.com.pe"
    "proyecto"    = "consumo-de-datos"
    "tf-module"   = "dl-etls"
  }
  connections = {
    "connection_name" = "REDSHIFT_PER_SUPER"
  }
  vpc_id = "vpc-08ac3c6ecbd3eeb44"
  subnet_ids = ["subnet-042dc17f748e11171", "subnet-07996b82f0d4ef4e4"]
  security_groups = ["sg-081e034bfce633daa"]
}