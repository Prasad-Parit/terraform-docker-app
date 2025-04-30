resource "aws_kms_key" "ebs" {
  description             = "KMS key for EBS encryption"
  deletion_window_in_days = 20
}

resource "aws_ebs_volume" "new_volume" {
  availability_zone = var.availability_zone
  size              = 1
  type              = "gp2"
  encrypted         = true
  kms_key_id        = aws_kms_key.ebs.arn

  tags = {
    Name = "KmsEncryptedEBSVolume"
  }
}

resource "aws_volume_attachment" "attach_volume" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.new_volume.id
  instance_id = var.instance_id
}

