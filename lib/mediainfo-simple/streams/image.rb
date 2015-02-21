class ImageStream < Stream
  attr_accessor :resolution
  attr_accessor :format
  
  attr_accessor :width
  attr_accessor :height
 
  def frame_size
    "#{width}x#{height}" if width && height
  end
end

