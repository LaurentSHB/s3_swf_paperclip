class Asset < ActiveRecord::Base
  validates_attachment_presence :asset
  has_attached_file :asset,
    :styles => {  :thumb => "60x60#",
                  :large => "120x120#"},
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "s3_swf_paperclip/images/:id/:style.:extension"
  validates_attachment_content_type :asset, :content_type => ['image/gif', 'image/jpeg', 'image/png', 'image/x-ms-bmp']
end
