CarrierWave.configure do |config|

  config.storage    = :aws
  config.aws_bucket = 'theyouthreview'
  config.aws_acl    = 'public-read'

  # Optionally define an asset host for configurations that are fronted by a
  # content host, such as CloudFront.
  config.asset_host = 'https://d1cndlyhl5fqed.cloudfront.net'

  # The maximum period for authenticated_urls is only 7 days.
  # config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

  # Set custom options such as cache control to leverage browser caching
  # config.aws_attributes = {
  #     expires: 1.week.from_now.httpdate,
  #     cache_control: 'max-age=604800'
  # }

  config.aws_credentials = {
      access_key_id:     AWS_CONFIG['access_key_id'],
      secret_access_key: AWS_CONFIG['secret_access_key'],
      region:            'us-west-2' # Required
  }

  # config.fog_provider = 'fog/aws'                        # required
  # config.fog_credentials = {
  #     provider:              'AWS',                        # required
  #     aws_access_key_id:     AWS_CONFIG['access_key_id'],                        # required
  #     aws_secret_access_key: AWS_CONFIG['secret_access_key'],                        # required
  #     region:                'us-west-2',                  # optional, defaults to 'us-east-1'
  #
  #     # host:                  'http://dgx0wu1owm34a.cloudfront.net/user/',             # optional, defaults to nil
  #     # endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
  # }
  # # config.asset_host = 'http://dgx0wu1owm34a.cloudfront.net/user/'
  # config.fog_directory  = 'theyouthreview'                          # required
  # config.fog_public     = true                                        # optional, defaults to true
  # config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
end

module CarrierWave
  module MiniMagick
    def resize_nocrop_noscale( w, h)
      manipulate! do |image|
        w_original = image[:width].to_f
        h_original = image[:height].to_f
        if w_original < w && h_original < h
          return image
        end
        # resize
        image.resize("#{w}x#{h}")
        image
      end
    end
    # def quality(percentage)
    #   manipulate! do |img|
    #     img.quality(percentage.to_s)
    #     img = yield(img) if block_given?
    #     img
    #   end
    # end
  end
end