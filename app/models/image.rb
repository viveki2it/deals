require 'rubygems'
require 'open-uri'

class Image < ActiveRecord::Base
  mount_uploader :image, DealImageUploader
  belongs_to :deal

  attr_accessor :image_remote_url
  validates :image ,:presence => {:if => Proc.new{|image| image.image_remote_url.to_s.blank?}}

  validate :get_image_from_url

  def get_image_from_url
    unless image_remote_url.to_s.blank?
      self.image = do_download_remote_image(image_remote_url)
    end
  end

  def do_download_remote_image(remote_image_url)
    io = open(URI.parse(remote_image_url))
    def io.original_filename; base_uri.path.split('/').last; end
    io.original_filename.blank? ? nil : io
  rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end
  
end
