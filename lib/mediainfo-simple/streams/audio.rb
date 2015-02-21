class AudioStream < Stream
  attr_accessor :duration
  attr_accessor :language
  
  attr_accessor :sampling_count
  attr_accessor :sampling_rate
  attr_accessor_alias :sample_rate, :sampling_rate

  attr_accessor :stream_size
  attr_accessor :bit_rate
  attr_accessor :bit_rate_mode
  attr_accessor :interleave_duration

  attr_accessor :resolution
  attr_accessor_alias :sample_bit_depth, :resolution

  attr_accessor :format
  attr_accessor :format_profile
  attr_accessor :format_version
  attr_accessor :format_info
  attr_accessor :format_settings_sbr
  attr_accessor :format_settings_endianness
  attr_accessor :format_settings_sign
  attr_accessor :codec_id
  attr_accessor :codec_info
  attr_accessor :codec
  attr_accessor :codec_id_hint
  attr_accessor :channel_positions

  attr_accessor :channel_s
  def stereo?; channels == 2; end
  def mono?;   channels == 1; end

  attr_accessor :encoded_date
  attr_accessor :tagged_date

  attr_accessor :menu_id
end

