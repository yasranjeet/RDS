resource "aws_security_group" "rds_security_group" {
  name        = "${var.environment}-${var.application}-rds-sg"
  description = "Security group for RDS instance"

  ingress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = var.cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name        = "${var.environment}-${var.application}-rds-sg",
      Environment = var.environment,
      Owner       = var.owner,
      CostCenter  = var.cost_center,
      Application = var.application,
    },
    var.tags
  )
}


resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.environment}-${var.application}-subnet-group"
  subnet_ids = var.subnet_ids
}