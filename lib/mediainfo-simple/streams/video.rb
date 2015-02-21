class VideoStream < Stream
  attr_accessor :duration
  
  attr_accessor :stream_size
  attr_accessor :bit_rate
  attr_accessor :nominal_bit_rate
  
  attr_accessor :bit_rate_mode
  def cbr?
    video? && 'Constant' == bit_rate_mode
  end

  def vbr?
    video? && !cbr?
  end

  attr_accessor :scan_order
  attr_accessor :scan_type
  def interlaced?
    video? && 'Interlaced' == scan_type
  end

  def progressive?
    video? && !interlaced?
  end

  attr_accessor :bitdepth
  attr_accessor_alias :bit_depth, :bitdepth

  attr_accessor :resolution

  attr_accessor :colorimetry
  attr_accessor :colorspace
  attr_accessor_alias :color_space, :colorspace

  attr_accessor :format
  attr_accessor :format_info
  attr_accessor :format_profile
  attr_accessor :format_version
  attr_accessor :format_settings_cabac
  attr_accessor :format_settings_reframes
  attr_accessor :format_settings_matrix
  attr_accessor :format_settings_gop
  attr_accessor :format_commercial
  
  attr_accessor :colour_primaries
  attr_accessor_alias :color_primaries, :colour_primaries

  attr_accessor :transfer_characteristics
  attr_accessor :matrix_coefficients

  attr_accessor :codec_id
  attr_accessor :codec_info
  attr_accessor :codec
  attr_accessor_alias :codec_id_info, :codec_info

  attr_accessor :frame_rate
  attr_accessor_alias :framerate, :frame_rate
  attr_accessor_alias :fps,       :frame_rate
  # to convert framerate string to a float
  # example: "25.000 fps" => 25.0 :
  def fps_float
    frame_rate[/[\d.]+/].to_f if frame_rate
  end

  attr_accessor :minimum_frame_rate
  attr_accessor_alias :min_framerate, :minimum_frame_rate
  attr_accessor_alias :min_fps,       :minimum_frame_rate
  # like above, to convert min_fps strng to a float:
  def min_fps_float
    minimum_frame_rate[/[\d.]+/].to_f if video?
  end

  attr_accessor :maximum_frame_rate
  attr_accessor_alias :max_framerate, :maximum_frame_rate
  attr_accessor_alias :max_fps,       :maximum_frame_rate
  def max_fps_float
    maximum_frame_rate[/[\d.]+/].to_f if video?
  end

  attr_accessor :frame_rate_mode

  attr_accessor :display_aspect_ratio

  attr_accessor :bits_pixel_frame  # "Bits-(Pixel*Frame)"

  attr_accessor :width
  attr_accessor :height

  def frame_size
    "#{width}x#{height}" if width && height
  end

  attr_accessor :encoded_date
  attr_accessor :tagged_date
  
  attr_accessor :standard
  attr_accessor :menu_id
end

