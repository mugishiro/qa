module PostsHelper
  require 'mini_magick'

  BASE_IMAGE_PATH = './app/assets/images/default.png'.freeze
  GRAVITY = 'center'.freeze
  TEXT_POSITION = '0,0'.freeze
  ROW_LIMIT = 8

  class << self
    def build(text)
      text = prepare_text(text)
      @image = MiniMagick::Image.open(BASE_IMAGE_PATH)
      configuration(text)
    end

    private

    def configuration(text)
      @image.combine_options do |config|
        config.gravity GRAVITY
        config.pointsize @font_size
        config.draw "text #{TEXT_POSITION} '#{text}'"
      end
    end

    # 背景にいい感じに収まるように文字を調整して返却
    def prepare_text(text)
      if text.length >= 90
        @font_size = 20
        indention_count = 50
      else
        indention_count = 30
        @font_size = 40
      end
      text.scan(/.{1,#{indention_count}}/)[0...ROW_LIMIT].join("\n")
    end
  end
end
