class Invoice < ActiveRecord::Base
  belongs_to :customer

  mount_uploader :picture, PictureUploader

end
