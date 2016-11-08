class Video < ApplicationRecord
  belongs_to :streaming_site
  belongs_to :user, required: false

  scope :published, -> { where(status: 'published') }

  validates :summary, presence: true
  validates :url, presence: true, uniqueness: true

  def publish!
    update(status: 'published', published_at: Time.current)
  end

  def update_from_source
    if url.present?
      begin
        video_info = VideoInfo.new(url)
 
        if video_info.available?
          self.title        = video_info.title
          self.description  = video_info.description
          self.channel_name = video_info.author
          self.channel_url  = video_info.author_url
          self.thumbnail_url_small   = video_info.thumbnail_small
          self.thumbnail_url_medium  = video_info.thumbnail_medium
          self.thumbnail_url_large   = video_info.thumbnail_large
          self.embed_url             = video_info.embed_url
          self.embed_code            = video_info.embed_code
          self.provider_published_at = video_info.date
          self.duration              = video_info.duration
        end
      rescue VideoInfo::UrlError => e
        puts "Error retrieving #{url}: #{e.to_s}"
      end
    end
  end
end
