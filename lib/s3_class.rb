class S3Class < AWS::S3::S3Object
  if Rails.env == "production"
    set_current_bucket_to 'assets.mecanic3d-production'
  else
    set_current_bucket_to 'assets.mecanic3d-alpha'
  end
end