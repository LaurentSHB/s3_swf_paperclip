require "s3_class"
class Asset < ActiveRecord::Base
  
  #validates_attachment_presence :asset
  has_attached_file :asset,
    :styles => {  :thumb => "60x60#",
    :large => "120x120#"},
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "s3_swf_paperclip/images/:id/:style.:extension"
  validates_attachment_content_type :asset, :content_type => ['image/gif', 'image/jpeg', 'image/png', 'image/x-ms-bmp']

  after_create :move_upload_from_temp_to_final_resting_place

  def move_upload_from_temp_to_final_resting_place
    # Rename the image on s3 (more of a move)
    AWS::S3::Base.establish_connection!(:access_key_id => S3SwfUpload::S3Config.access_key_id,:secret_access_key => S3SwfUpload::S3Config.secret_access_key)
    new_name = self.asset.path
    old_name = "#{self.asset_file_name}"
    (1..5).each do
      begin
        # Copy the file
        AWS::S3::S3Object.rename(old_name, new_name, S3SwfUpload::S3Config.bucket, :copy_acl => :true)
        self.asset.reprocess!
        break
      rescue Exception => e
        sleep 1
      end
    end
  end
end